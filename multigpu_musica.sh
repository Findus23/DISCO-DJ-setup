#!/bin/bash

echo "running jobscript on $(hostname)"
echo $SLURM_NODELIST

# ml Python

# export LD_LIBRARY_PATH=$LIBRARY_PATH


NAME=$1
shift # remove from $@
OUTPUT_DIR="data/output/gpu_${NAME}_${SLURM_JOB_ID}/"

source /data/fs201207/lw45555/venv/discodj-refactor/bin/activate

cd ~/DISCO-DJ/refactor/

export PYTHONUNBUFFERED=1

# export XLA_PYTHON_CLIENT_PREALLOCATE=false
# export XLA_PYTHON_CLIENT_PREALLOCATE=false
export XLA_PYTHON_CLIENT_MEM_FRACTION=0.95
# export XLA_PYTHON_CLIENT_ALLOCATOR=platform
export TF_GPU_ALLOCATOR=cuda_malloc_async
export JAX_TRACEBACK_FILTERING=off
# export XLA_FLAGS=--xla_dump_to=/home/fs72085/lwinkler/DISCO-DJ/scripts/tmp/
#export JAX_LOG_COMPILES=1

export NCCL_DEBUG=TRACE
export NCCL_NVLS_ENABLE=1
# export CUDA_DEVICE_MAX_CONNECTIONS=1


# export NCCL_CUMEM_ENABLE=0

export TF_CPP_MIN_LOG_LEVEL=0

export XLA_FLAGS="--xla_gpu_enable_latency_hiding_scheduler=true --xla_gpu_allow_ragged_all_to_all_nccl_send_recv_fallback=true --xla_gpu_unsupported_enable_ragged_all_to_all_multi_host_decomposer=false --xla_disable_hlo_passes=rematerialization"


# export NCCL_PROFILER_PLUGIN="/home/lw45555/ncclsee/build/libnccl-profiler.so"
# export NCCLSEE_LOG_LEVEL=debug
# export NCCLSEE_MODE=tracer


# export XLA_FLAGS="--xla_gpu_enable_latency_hiding_scheduler=true --xla_gpu_pgle_profile_file_or_directory_path=data/jax_profiler/gpu_multigpu_4096_profiler_45285/plugins/profile/2025_11_25_14_26_11/profile_0.pb"

# export JAX_SHARE_BINARY_BETWEEN_HOSTS=1
#
# export TF_CPP_VMODULE="xla=2,xla_compiler=2"
# export JAX_LOG_COMPILES=1

export BLOSC_NTHREADS=22

srun --output "own/output/slurm-%2j-%2t.out" ~/nsys/pkg/bin/nsys profile -t nccl,cuda,nvtx,cudnn,cublas,cusparse,cusolver,python-gil --cuda-memory-usage true --cuda-graph-trace=node --output "data/profiler/disco-sim-%q{SLURM_JOB_ID}-%q{SLURM_PROCID}" disco-sim --jax-fixes --ext.output.directory "$OUTPUT_DIR" $@
# srun --output "own/output/slurm-%2j-%2t.out" disco-sim --jax-fixes --ext.output.directory "$OUTPUT_DIR" $@


