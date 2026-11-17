#!/bin/bash

echo "running jobscript on $(hostname)"
echo $SLURM_NODELIST


# export LD_LIBRARY_PATH=$LIBRARY_PATH

export CMAKE_BUILD_PARALLEL_LEVEL=20
export CUDAARCHS=90

eval "$(~/miniforge3/bin/conda 'shell.bash' 'hook')"
conda activate discodj-refactor

ml gsl

which python
python --version

cd ~/DISCO-DJ/refactor/

cd own/

export CMAKE_BUILD_PARALLEL_LEVEL=10
export CUDAARCHS=80


pip install -r pip/requirements-gpu-cuda12_local.txt
pip install -r pip/requirements-jztree.txt --no-build-isolation
pip install -r pip/requirements-analysis.txt

cd ../
pip install -e . --no-build-isolation -vv
pip install -e analysis --no-build-isolation -vv