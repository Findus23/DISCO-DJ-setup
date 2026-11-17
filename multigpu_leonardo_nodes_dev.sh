#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=l.winkler@univie.ac.at
#SBATCH --time=00:10:00
#SBATCH --tasks-per-node=4
#SBATCH --exclusive
#SBATCH --job-name=discodj-multigpu
#SBATCH --gpus-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH --gpu-bind=closest
#SBATCH --qos=boost_qos_dbg
#SBATCH --partition=boost_usr_prod
#SBATCH --account=L-AUT_Hahn_26
#SBATCH --output output/slurm-%j.out

./multigpu_leonardo.sh $@

