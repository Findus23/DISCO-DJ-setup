#!/bin/bash

echo "running jobscript on $(hostname)"
echo $SLURM_NODELIST

module load gsl
export LD_LIBRARY_PATH=$LIBRARY_PATH


NAME=$1
shift # remove from $@
OUTPUT_DIR="data/output/gpu_${NAME}_${SLURM_JOB_ID}/"

eval "$(~/miniforge3/bin/conda 'shell.bash' 'hook')"
conda activate discodj-refactor

cd ~/DISCO-DJ/refactor/

export PYTHONUNBUFFERED=1

# export XLA_PYTHON_CLIENT_PREALLOCATE=false
# export XLA_PYTHON_CLIENT_PREALLOCATE=false
export XLA_PYTHON_CLIENT_MEM_FRACTION=0.85
# export XLA_PYTHON_CLIENT_ALLOCATOR=platform
export TF_GPU_ALLOCATOR=cuda_malloc_async
export JAX_TRACEBACK_FILTERING=off
# export XLA_FLAGS=--xla_dump_to=/home/fs72085/lwinkler/DISCO-DJ/scripts/tmp/
#export JAX_LOG_COMPILES=1

export NCCL_DEBUG=TRACE
export NCCL_NVLS_ENABLE=1
# export CUDA_DEVICE_MAX_CONNECTIONS=1

export TF_CPP_MIN_LOG_LEVEL=0

export XLA_FLAGS="--xla_disable_hlo_passes=rematerialization"


# export NCCL_PROFILER_PLUGIN="/leonardo/home/userexternal/lwinkler/nccl/ext-profiler/inspector/libnccl-profiler-inspector.so"
# export NCCL_PROFILER_PLUGIN="/leonardo/home/userexternal/lwinkler/ncclsee/build/libnccl-profiler.so"
# export NCCLSEE_LOG_LEVEL=debug
# export NCCLSEE_MODE=tracer
# export NCCL_INSPECTOR_ENABLE=1
# export NCCL_INSPECTOR_DUMP_THREAD_INTERVAL_MICROSECONDS=500
# export NCCL_INSPECTOR_DUMP_DIR=/leonardo/home/userexternal/lwinkler/DISCO-DJ/master/data/nccl-log/${SLURM_JOB_ID}/
# export NCCLSEE_OUTPUT_DIR="/leonardo/home/userexternal/lwinkler/"
# export NCCLSEE_OUTPUT_FILE="ncclsee.csv"
# export NCCL_INSPECTOR_DUMP_VERBOSE=1

# export JAX_SHARE_BINARY_BETWEEN_HOSTS=1
#
# export TF_CPP_VMODULE="xla=2,xla_compiler=2"
# export JAX_LOG_COMPILES=1


# export XLA_FLAGS="--xla_gpu_enable_command_buffer="

export BLOSC_NTHREADS=10 # TODO: replace

srun --output "own/output/slurm-%2j-%2t.out" ~/nsys/pkg/bin/nsys profile -t nccl,cuda,nvtx,cudnn,cublas,cusparse,cusolver,python-gil --cuda-memory-usage true --cuda-graph-trace=node --output "data/profiler/disco-sim-%q{SLURM_JOB_ID}-%q{SLURM_PROCID}" disco-sim --jax-fixes --ext.output.directory "$OUTPUT_DIR" $@
# srun --output "own/output/slurm-%2j-%2t.out" disco-sim --jax-fixes --ext.output.directory "$OUTPUT_DIR" $@

