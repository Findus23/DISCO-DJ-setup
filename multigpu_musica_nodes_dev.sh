#!/bin/bash
#ASC --vanilla
#SBATCH --mail-type=ALL
#SBATCH --mail-user=l.winkler@univie.ac.at
#SBATCH --time=00:10:00
#SBATCH --tasks-per-node=4
#SBATCH --exclusive
#SBATCH --job-name=discodj-multigpu
#SBATCH --gpus-per-node=4
#SBATCH --cpus-per-task=48
#SBATCH --qos=dev_zen4_0768_h100x4
#SBATCH --partition=zen4_0768_h100x4
#SBATCH --output output/slurm-%j.out

./multigpu_musica.sh $@

