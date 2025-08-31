# The use of PyTorch in Triton programs is not allowed for the purposes of fair benchmarking.
import triton
import triton.language as tl

@triton.jit
def matrix_multiplication_kernel(
    a_ptr, b_ptr, c_ptr,
    M, N, K,
    stride_am, stride_ak,
    stride_bk, stride_bn,
    stride_cm, stride_cn,
    BLOCK_SIZE_M: tl.constexpr, 
    BLOCK_SIZE_N: tl.constexpr,
    BLOCK_SIZE_K: tl.constexpr,
):
    a_ptr = a_ptr.to(tl.pointer_type(tl.bfloat16))
    b_ptr = b_ptr.to(tl.pointer_type(tl.bfloat16))
    c_ptr = c_ptr.to(tl.pointer_type(tl.float32))
    pid_n = tl.program_id(axis=0)
    pid_m = tl.program_id(axis=1)

    offs_m = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_n = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    offs_k = tl.arange(0, BLOCK_SIZE_K)

    # 初始化A和B的指针
    a_ptrs = a_ptr + offs_m[:, None] * stride_am + offs_k[None, :] * stride_ak
    b_ptrs = b_ptr + offs_k[:, None] * stride_bk + offs_n[None, :] * stride_bn

    accumulator = tl.zeros((BLOCK_SIZE_M, BLOCK_SIZE_N), dtype=tl.float32)

    # 沿N维度按块累加
    for k in range(0, tl.cdiv(K, BLOCK_SIZE_K)):
        max_idx = K - k * BLOCK_SIZE_K
        # 加载A和B的块
        a = tl.load(a_ptrs + k * BLOCK_SIZE_K * stride_ak, mask=offs_k[None, :] < max_idx, other=0.0)
        b = tl.load(b_ptrs + k * BLOCK_SIZE_K * stride_bk, mask=offs_k[:, None] < max_idx, other=0.0)
        # 计算a @ b，累加到 accumulator
        accumulator += tl.dot(a, b)

    # 将结果写回C
    c_ptrs = c_ptr + offs_m[:, None] * stride_cm + offs_n[None, :] * stride_cn
    offs_cm = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_ck = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    c_mask = (offs_cm[:, None] < M) & (offs_ck[None, :] < N)
    tl.store(c_ptrs, accumulator, mask=c_mask)

# a_ptr, b_ptr, c_ptr are raw device pointers
def solve(a_ptr, b_ptr, c_ptr, M: int, N: int, K: int):
    stride_am, stride_ak = K, 1
    stride_bk, stride_bn = N, 1
    stride_cm, stride_cn = N, 1

    grid = lambda META: (triton.cdiv(N, META['BLOCK_SIZE_N']), triton.cdiv(M, META['BLOCK_SIZE_M']), )
    matrix_multiplication_kernel[grid](
        a_ptr, b_ptr, c_ptr,
        M, N, K,
        stride_am, stride_ak,
        stride_bk, stride_bn,
        stride_cm, stride_cn,
        BLOCK_SIZE_M=128,
        BLOCK_SIZE_N=64,
        BLOCK_SIZE_K=64,
    )

M, N, K = 8192, 6144, 4096

import torch
device = torch.cuda.current_device()

A = torch.randn(M, K, device=device, dtype=torch.bfloat16)
B = torch.randn(K, N, device=device, dtype=torch.bfloat16)
C = torch.randn(M, N, device=device, dtype=torch.float32)
solve(A, B, C, M, N, K)
torch_output = torch.mm(A, B, torch.float32)

if torch.allclose(C, torch_output, atol=0.125, rtol=0):
    print("✅ Triton and Torch match")
else:
    print("❌ Triton and Torch differ")
