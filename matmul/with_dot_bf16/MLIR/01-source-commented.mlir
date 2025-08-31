// Next run Pass --inline
// IR Dump After Python ast_to_ttir

#loc = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0)
#loc65 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":31:0)
module {
  tt.func public @matrix_multiplication_kernel(%arg0: !tt.ptr<bf16> {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg1: !tt.ptr<bf16> {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg2: !tt.ptr<f32> {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg3: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg4: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg5: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg6: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg7: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0), %arg8: i32 {tt.divisibility = 16 : i32} loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":6:0)) attributes {noinline = false} {
    // pid_n = tl.program_id(axis=0)
    %0 = tt.get_program_id x : i32 loc(#loc1)
    // pid_m = tl.program_id(axis=1)
    %1 = tt.get_program_id y : i32 loc(#loc2)

    ///////////////////////////////////////////////////////////////////////////
    // offs_m = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    ///////////////////////////////////////////////////////////////////////////
    // BLOCK_SIZE_M=128（实际上声明了好几个常量，省略没用到的）
    %c128_i32_0 = arith.constant 128 : i32 loc(#loc3)
    // binary_op_sanitize_overflow_impl
    // 转换到 i64 检查溢出
    %2 = arith.extsi %1 : i32 to i64 loc(#loc3)
    %3 = arith.extsi %c128_i32_0 : i32 to i64 loc(#loc3)
    %4 = arith.muli %2, %3 : i64 loc(#loc3)
    %c2147483647_i64 = arith.constant 2147483647 : i64 loc(#loc3)
    %c-2147483648_i64 = arith.constant -2147483648 : i64 loc(#loc3)
    %5 = arith.cmpi sle, %4, %c2147483647_i64 : i64 loc(#loc3)
    %6 = arith.cmpi sge, %4, %c-2147483648_i64 : i64 loc(#loc3)
    %7 = arith.andi %5, %6 : i1 loc(#loc3)
    // @triton.jit(debug=True) 时 %7 会生成一句 device_assert，这里没有
    %8 = arith.muli %1, %c128_i32_0 : i32 loc(#loc3)
    // tl.arange(0, BLOCK_SIZE_M)
    %9 = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32> loc(#loc4)
    // i32 + tensor<128xi32>，标量转张量
    %10 = tt.splat %8 : i32 -> tensor<128xi32> loc(#loc5)
    // [检查溢出……]
    %17 = arith.addi %10, %9 : tensor<128xi32> loc(#loc5)

    ///////////////////////////////////////////////////////////////////////////
    // offs_n = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    ///////////////////////////////////////////////////////////////////////////
    // BLOCK_SIZE_N=64
    %c64_i32_4 = arith.constant 64 : i32 loc(#loc6)
    // [检查溢出……]
    // pid_nk * BLOCK_SIZE_N
    %24 = arith.muli %0, %c64_i32_4 : i32 loc(#loc6)
    // tl.arange(0, BLOCK_SIZE_N)
    %25 = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32> loc(#loc7)
    %26 = tt.splat %24 : i32 -> tensor<64xi32> loc(#loc8)
    // [检查溢出……]
    %33 = arith.addi %26, %25 : tensor<64xi32> loc(#loc8)

    ///////////////////////////////////////////////////////////////////////////
    // offs_k = tl.arange(0, BLOCK_SIZE_K)
    ///////////////////////////////////////////////////////////////////////////
    %34 = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32> loc(#loc9)

    ///////////////////////////////////////////////////////////////////////////
    // a_ptrs = a_ptr + offs_m[:, None] * stride_am + offs_k[None, :] * stride_ak
    ///////////////////////////////////////////////////////////////////////////
    // offs_m[:, None] 对应 tt.expand_dims
    %35 = tt.expand_dims %17 {axis = 1 : i32} : tensor<128xi32> -> tensor<128x1xi32> loc(#loc10)
    %36 = tt.splat %arg6 : i32 -> tensor<128x1xi32> loc(#loc11)
    // [检查溢出……]
    %43 = arith.muli %35, %36 : tensor<128x1xi32> loc(#loc11)
    // a_ptr -> tensor
    %44 = tt.splat %arg0 : !tt.ptr<bf16> -> tensor<128x1x!tt.ptr<bf16>> loc(#loc12)
    %45 = tt.addptr %44, %43 : tensor<128x1x!tt.ptr<bf16>>, tensor<128x1xi32> loc(#loc12)
    %46 = tt.expand_dims %34 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32> loc(#loc13)
    %c1_i32_15 = arith.constant 1 : i32 loc(#loc14)
    %cst_16 = arith.constant dense<1> : tensor<1x64xi32> loc(#loc14)
    // [检查溢出……]
    %53 = arith.muli %46, %cst_16 : tensor<1x64xi32> loc(#loc14)
    // 处理广播
    %54 = tt.broadcast %45 : tensor<128x1x!tt.ptr<bf16>> -> tensor<128x64x!tt.ptr<bf16>> loc(#loc15)
    %55 = tt.broadcast %53 : tensor<1x64xi32> -> tensor<128x64xi32> loc(#loc15)
    %56 = tt.addptr %54, %55 : tensor<128x64x!tt.ptr<bf16>>, tensor<128x64xi32> loc(#loc15)

    ///////////////////////////////////////////////////////////////////////////
    // b_ptrs = b_ptr + offs_k[:, None] * stride_bk + offs_n[None, :] * stride_bn
    ///////////////////////////////////////////////////////////////////////////
    %57 = tt.expand_dims %34 {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32> loc(#loc16)
    %58 = tt.splat %arg7 : i32 -> tensor<64x1xi32> loc(#loc17)
    // [检查溢出……]
    %65 = arith.muli %57, %58 : tensor<64x1xi32> loc(#loc17)
    %66 = tt.splat %arg1 : !tt.ptr<bf16> -> tensor<64x1x!tt.ptr<bf16>> loc(#loc18)
    %67 = tt.addptr %66, %65 : tensor<64x1x!tt.ptr<bf16>>, tensor<64x1xi32> loc(#loc18)
    %68 = tt.expand_dims %33 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32> loc(#loc19)
    %c1_i32_25 = arith.constant 1 : i32 loc(#loc20)
    %c1_i32_26 = arith.constant 1 : i32 loc(#loc20)
    %cst_27 = arith.constant dense<1> : tensor<1x64xi32> loc(#loc20)
    // [检查溢出……]
    %75 = arith.muli %68, %cst_27 : tensor<1x64xi32> loc(#loc20)
    %76 = tt.broadcast %67 : tensor<64x1x!tt.ptr<bf16>> -> tensor<64x64x!tt.ptr<bf16>> loc(#loc21)
    %77 = tt.broadcast %75 : tensor<1x64xi32> -> tensor<64x64xi32> loc(#loc21)
    %78 = tt.addptr %76, %77 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32> loc(#loc21)

    ///////////////////////////////////////////////////////////////////////////
    // accumulator = tl.zeros((BLOCK_SIZE_M, BLOCK_SIZE_N), dtype=tl.float32)
    ///////////////////////////////////////////////////////////////////////////
    %79 = tt.call @"triton.language.standard.zeros____(0, 0)cconstexpr_128__(0, 1)cconstexpr_64__(1,)cconstexpr_fp32_"() : () -> tensor<128x64xf32> loc(#loc22)
    ///////////////////////////////////////////////////////////////////////////
    // for k in range(0, tl.cdiv(K, BLOCK_SIZE_K)):
    ///////////////////////////////////////////////////////////////////////////
    %80 = tt.call @"triton.language.standard.cdiv__i32__(1,)cconstexpr_64_"(%arg5) : (i32) -> i32 loc(#loc23)
    %c0_i32 = arith.constant 0 : i32 loc(#loc24)
    %c1_i32_32 = arith.constant 1 : i32 loc(#loc24)
    %81 = arith.bitcast %c0_i32 : i32 to i32 loc(#loc24)
    %82 = arith.bitcast %80 : i32 to i32 loc(#loc24)
    %83 = arith.bitcast %c1_i32_32 : i32 to i32 loc(#loc24)
    %84 = ub.poison : i32 loc(#loc24)
    // 注意 scf 的写法，iter_args表示每个循环会改变的量
    // %arg10 表示 accumulator，初始化为 %79（全零）
    %85 = scf.for %arg9 = %81 to %82 step %83 iter_args(%arg10 = %79) -> (tensor<128x64xf32>)  : i32 {
      ///////////////////////////////////////////////////////////////////////////
      // max_idx = K - k * BLOCK_SIZE_K
      ///////////////////////////////////////////////////////////////////////////
      // BLOCK_SIZE_K=64
      %c64_i32_61 = arith.constant 64 : i32 loc(#loc25)
      // [检查溢出……]
      %155 = arith.muli %arg9, %c64_i32_61 : i32 loc(#loc25)
      // [检查溢出……]
      %162 = arith.subi %arg4, %155 : i32 loc(#loc26)
      %163 = tt.expand_dims %34 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32> loc(#loc27)
      %164 = tt.splat %162 : i32 -> tensor<1x64xi32> loc(#loc28)
      %165 = arith.cmpi slt, %163, %164 : tensor<1x64xi32> loc(#loc28)

      ///////////////////////////////////////////////////////////////////////////
      // a = tl.load(a_ptrs + k * BLOCK_SIZE_K * stride_ak, mask=offs_k[None, :] < max_idx, other=0.0)
      ///////////////////////////////////////////////////////////////////////////
      %c64_i32_67 = arith.constant 64 : i32 loc(#loc29)
      // [检查溢出……]
      %172 = arith.muli %arg9, %c64_i32_67 : i32 loc(#loc29
      %c1_i32_71 = arith.constant 1 : i32 loc(#loc30)
      // [检查溢出……]
      %179 = arith.muli %172, %c1_i32_71 : i32 loc(#loc30)
      %180 = tt.splat %179 : i32 -> tensor<128x64xi32> loc(#loc31)
      %181 = tt.addptr %56, %180 : tensor<128x64x!tt.ptr<bf16>>, tensor<128x64xi32> loc(#loc31)
      %cst_74 = arith.constant 0.000000e+00 : f32 loc(#loc32)
      %182 = tt.broadcast %165 : tensor<1x64xi1> -> tensor<128x64xi1> loc(#loc32)
      %cst_75 = arith.constant dense<0.000000e+00> : tensor<128x64xf32> loc(#loc32)
      // 注意输入的是 f32，所以用 arith.truncf 转换一下
      %183 = arith.truncf %cst_75 : tensor<128x64xf32> to tensor<128x64xbf16> loc(#loc32)
      %184 = tt.load %181, %182, %183 : tensor<128x64x!tt.ptr<bf16>> loc(#loc32)

      ///////////////////////////////////////////////////////////////////////////
      // b = tl.load(b_ptrs + k * BLOCK_SIZE_K * stride_bk, mask=offs_k[:, None] < max_idx, other=0.0)
      ///////////////////////////////////////////////////////////////////////////
      %185 = tt.expand_dims %34 {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32> loc(#loc33)
      %186 = tt.splat %162 : i32 -> tensor<64x1xi32> loc(#loc34)
      %187 = arith.cmpi slt, %185, %186 : tensor<64x1xi32> loc(#loc34)
      %c64_i32_77 = arith.constant 64 : i32 loc(#loc35)
      // [检查溢出……]
      %194 = arith.muli %arg9, %c64_i32_77 : i32 loc(#loc35)
      // [检查溢出……]
      %201 = arith.muli %194, %arg7 : i32 loc(#loc36)
      %202 = tt.splat %201 : i32 -> tensor<64x64xi32> loc(#loc37)
      %203 = tt.addptr %78, %202 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32> loc(#loc37)
      %cst_82 = arith.constant 0.000000e+00 : f32 loc(#loc38)
      %204 = tt.broadcast %187 : tensor<64x1xi1> -> tensor<64x64xi1> loc(#loc38)
      %cst_83 = arith.constant dense<0.000000e+00> : tensor<64x64xf32> loc(#loc38)
      %205 = arith.truncf %cst_83 : tensor<64x64xf32> to tensor<64x64xbf16> loc(#loc38)
      %206 = tt.load %203, %204, %205 : tensor<64x64x!tt.ptr<bf16>> loc(#loc38)

      ///////////////////////////////////////////////////////////////////////////
      // accumulator += tl.dot(a, b)
      ///////////////////////////////////////////////////////////////////////////
      // 注意这里是先计算了tl.dot(a, b, 0)，然后再加到 accumulator 上
      // 在 TritonCombineOps 中融合到一起
      %cst_85 = arith.constant dense<0.000000e+00> : tensor<128x64xf32> loc(#loc39)
      %207 = tt.dot %184, %206, %cst_85, inputPrecision = tf32 : tensor<128x64xbf16> * tensor<64x64xbf16> -> tensor<128x64xf32> loc(#loc39)
      %208 = arith.addf %arg10, %207 : tensor<128x64xf32> loc(#loc40)
      scf.yield %208 : tensor<128x64xf32> loc(#loc41)
    } loc(#loc24)
    // 后面 epilogue 没什么新语法，不看了
    %86 = tt.expand_dims %17 {axis = 1 : i32} : tensor<128xi32> -> tensor<128x1xi32> loc(#loc42)
    %87 = tt.splat %arg8 : i32 -> tensor<128x1xi32> loc(#loc43)
    // [检查溢出……]
    %94 = arith.muli %86, %87 : tensor<128x1xi32> loc(#loc43)
    %95 = tt.splat %arg2 : !tt.ptr<f32> -> tensor<128x1x!tt.ptr<f32>> loc(#loc44)
    %96 = tt.addptr %95, %94 : tensor<128x1x!tt.ptr<f32>>, tensor<128x1xi32> loc(#loc44)
    %97 = tt.expand_dims %33 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32> loc(#loc45)
    %c1_i32_37 = arith.constant 1 : i32 loc(#loc46)
    %c1_i32_38 = arith.constant 1 : i32 loc(#loc46)
    %cst_39 = arith.constant dense<1> : tensor<1x64xi32> loc(#loc46)
    // [检查溢出……]
    %104 = arith.muli %97, %cst_39 : tensor<1x64xi32> loc(#loc46)
    %105 = tt.broadcast %96 : tensor<128x1x!tt.ptr<f32>> -> tensor<128x64x!tt.ptr<f32>> loc(#loc47)
    %106 = tt.broadcast %104 : tensor<1x64xi32> -> tensor<128x64xi32> loc(#loc47)
    %107 = tt.addptr %105, %106 : tensor<128x64x!tt.ptr<f32>>, tensor<128x64xi32> loc(#loc47)
    %c128_i32_44 = arith.constant 128 : i32 loc(#loc48)
    %c128_i32_45 = arith.constant 128 : i32 loc(#loc48)
    // [检查溢出……]
    %114 = arith.muli %1, %c128_i32_45 : i32 loc(#loc48)
    %115 = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32> loc(#loc49)
    %116 = tt.splat %114 : i32 -> tensor<128xi32> loc(#loc50)
    // [检查溢出……]
    %123 = arith.addi %116, %115 : tensor<128xi32> loc(#loc50)
    %c64_i32_52 = arith.constant 64 : i32 loc(#loc51)
    %c64_i32_53 = arith.constant 64 : i32 loc(#loc51)
    // [检查溢出……]
    %130 = arith.muli %0, %c64_i32_53 : i32 loc(#loc51)
    %131 = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32> loc(#loc52)
    %132 = tt.splat %130 : i32 -> tensor<64xi32> loc(#loc53)
    // [检查溢出……]
    %139 = arith.addi %132, %131 : tensor<64xi32> loc(#loc53)
    %140 = tt.expand_dims %123 {axis = 1 : i32} : tensor<128xi32> -> tensor<128x1xi32> loc(#loc54)
    %141 = tt.splat %arg3 : i32 -> tensor<128x1xi32> loc(#loc55)
    %142 = arith.cmpi slt, %140, %141 : tensor<128x1xi32> loc(#loc55)
    %143 = tt.expand_dims %139 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32> loc(#loc56)
    %144 = tt.splat %arg5 : i32 -> tensor<1x64xi32> loc(#loc57)
    %145 = arith.cmpi slt, %143, %144 : tensor<1x64xi32> loc(#loc57)
    %146 = tt.broadcast %142 : tensor<128x1xi1> -> tensor<128x64xi1> loc(#loc58)
    %147 = tt.broadcast %145 : tensor<1x64xi1> -> tensor<128x64xi1> loc(#loc58)
    %148 = arith.andi %146, %147 : tensor<128x64xi1> loc(#loc58)
    tt.store %107, %85, %148 : tensor<128x64x!tt.ptr<f32>> loc(#loc59)
    tt.return loc(#loc60)
  } loc(#loc)
  tt.func private @"triton.language.standard.zeros____(0, 0)cconstexpr_128__(0, 1)cconstexpr_64__(1,)cconstexpr_fp32_"() -> tensor<128x64xf32> attributes {noinline = false} {
    %cst = arith.constant 0.000000e+00 : f32 loc(#loc62)
    %cst_0 = arith.constant dense<0.000000e+00> : tensor<128x64xf32> loc(#loc62)
    tt.return %cst_0 : tensor<128x64xf32> loc(#loc63)
  ^bb1:  // no predecessors
    %0 = ub.poison : tensor<128x64xf32> loc(#loc64)
    tt.return %0 : tensor<128x64xf32> loc(#loc64)
  } loc(#loc61)
  tt.func private @"triton.language.standard.cdiv__i32__(1,)cconstexpr_64_"(%arg0: i32 loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":31:0)) -> i32 attributes {noinline = false} {
    %c64_i32 = arith.constant 64 : i32 loc(#loc66)
    %c64_i32_0 = arith.constant 64 : i32 loc(#loc66)
    // [检查溢出……]
    %6 = arith.addi %arg0, %c64_i32_0 : i32 loc(#loc66)
    %c1_i32 = arith.constant 1 : i32 loc(#loc67)
    %c1_i32_1 = arith.constant 1 : i32 loc(#loc67)
    // [检查溢出……]
    %13 = arith.subi %6, %c1_i32_1 : i32 loc(#loc67)
    %c64_i32_4 = arith.constant 64 : i32 loc(#loc68)
    %c64_i32_5 = arith.constant 64 : i32 loc(#loc68)
    %14 = arith.divsi %13, %c64_i32_5 : i32 loc(#loc68)
    tt.return %14 : i32 loc(#loc69)
  ^bb1:  // no predecessors
    %15 = ub.poison : i32 loc(#loc70)
    tt.return %15 : i32 loc(#loc70)
  } loc(#loc65)
} loc(#loc)
#loc1 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":18:26)
#loc2 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":19:26)
#loc3 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":21:21)
#loc4 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":21:49)
#loc5 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":21:36)
#loc6 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":22:21)
#loc7 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":22:49)
#loc8 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":22:36)
#loc9 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":23:26)
#loc10 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:28)
#loc11 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:39)
#loc12 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:21)
#loc13 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:58)
#loc14 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:69)
#loc15 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":26:51)
#loc16 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:28)
#loc17 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:39)
#loc18 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:21)
#loc19 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:58)
#loc20 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:69)
#loc21 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":27:51)
#loc22 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":29:27)
#loc23 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":32:33)
#loc24 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":32:22)
#loc25 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":33:26)
#loc26 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":33:22)
#loc27 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:71)
#loc28 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:82)
#loc29 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:33)
#loc30 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:48)
#loc31 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:29)
#loc32 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":35:20)
#loc33 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:71)
#loc34 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:82)
#loc35 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:33)
#loc36 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:48)
#loc37 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:29)
#loc38 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":36:20)
#loc39 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":38:33)
#loc40 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":38:23)
#loc41 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":38:8)
#loc42 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:28)
#loc43 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:39)
#loc44 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:21)
#loc45 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:58)
#loc46 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:69)
#loc47 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":41:51)
#loc48 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":42:22)
#loc49 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":42:50)
#loc50 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":42:37)
#loc51 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":43:22)
#loc52 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":43:50)
#loc53 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":43:37)
#loc54 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":44:22)
#loc55 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":44:33)
#loc56 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":44:47)
#loc57 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":44:58)
#loc58 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":44:39)
#loc59 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":45:21)
#loc60 = loc("/workspace/Triton-blog-file/matmul/kernel/matmul-with-dot-bf16.py":45:4)
#loc61 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":117:0)
#loc62 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":126:31)
#loc63 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":126:11)
#loc64 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":126:4)
#loc66 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":40:16)
#loc67 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":40:22)
#loc68 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":40:28)
#loc69 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":40:11)
#loc70 = loc("/workspace/Triton-blog-file/.venv/lib/python3.10/site-packages/triton/language/standard.py":40:4)
