#!/bin/bash
#ASC --vanilla
#SBATCH --mail-type=FAIL,REQUEUE,INVALID_DEPEND,STAGE_OUT
#SBATCH --mail-user=l.winkler@univie.ac.at
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH -p zen4_0768_h100x4
#SBATCH --qos dev_zen4_0768_h100x4
#SBATCH --time=00:10:00
#SBATCH --job-name=discodj-1gpu
#SBATCH --output output/slurm-%j.out

# Usage: sbatch [--time HH:MM:SS] [-J X] multigpu_musica_single_gpu.sh <run name> <disco-sim args...>
# Single-GPU variant of multigpu_musica_nodes.sh.
./multigpu_musica.sh $@

