#!/bin/bash
#ASC --vanilla
#SBATCH --mail-type=ALL
#SBATCH --mail-user=l.winkler@univie.ac.at
#SBATCH --time=00:10:00
#SBATCH --nodes=1 #equal to -N 1
#SBATCH --tasks-per-node=1
#SBATCH --exclusive
#SBATCH --job-name=compile_cuda
#SBATCH --gpus=4
##SBATCH --gpus-per-task=1
##SBATCH --gpu-bind=closest
#SBATCH --qos=dev_zen4_0768_h100x4
#SBATCH --partition=zen4_0768_h100x4
#SBATCH --output output/cuda-compile-%j.out

echo "running jobscript on $(hostname)"
echo $SLURM_NODELIST

module purge
# ml Python
ml buildenv/default-foss-2025a
which python

# export LD_LIBRARY_PATH=$LIBRARY_PATH

export CMAKE_BUILD_PARALLEL_LEVEL=20
export CUDAARCHS=90

source /data/fs201207/lw45555/venv/discodj-refactor/bin/activate
which python
python --version

cd ~/DISCO-DJ/refactor/


uv pip install "jax[cuda13]" nvidia-cuda-nvcc "scikit-build-core>=0.12.1" "nanobind>=3.1.0" "cmake>=3.24" "setuptools-scm>=8"
uv pip install -e ".[all-cuda13]" --no-build-isolation -Cbuild-dir=build/{wheel_tag} -v
