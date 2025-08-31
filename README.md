# Blog Files with Triton

## Environment

```shell
pip install torch==2.8 triton==3.4 numpy
```


## How to dump the IR by pass

```shell
export MLIR_ENABLE_DUMP=1
export MLIR_DUMP_PATH=matmul/with_dot_bf16/MLIR/full.mlir
rm -r ~/.triton/cache/ # Optional, if nothing is dumped
python matmul/kernel/matmul-with-dot-bf16.py
python format-dump.py $MLIR_DUMP_PATH
python generate_all_diffs.py $(dirname $MLIR_DUMP_PATH)
rm $MLIR_DUMP_PATH
```


## From BobHuang

[深度剖析 Triton编译器 MatMul优化（三）—— TMA](https://zhuanlan.zhihu.com/p/1924011555437155686)

[深度剖析 Triton编译器 MatMul优化（二）—— MMA](https://zhuanlan.zhihu.com/p/1922921325296615496)

[深度剖析 Triton编译器 MatMul优化（一）—— FMA](https://zhuanlan.zhihu.com/p/1922542705797465957)
