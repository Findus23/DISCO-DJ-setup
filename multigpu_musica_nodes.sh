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
#SBATCH --qos=zen4_0768_h100x4
#SBATCH --partition=zen4_0768_h100x4
#SBATCH --output output/slurm-%j.out

# Usage: sbatch -N <nodes> [--time HH:MM:SS] [--job-name X] multigpu_musica_nodes.sh <run name> <disco-sim args...>
# The node count is NOT set here; pass -N/--nodes to sbatch (GPUs follow via --gpus-per-node).
if [ -z "$SLURM_JOB_NUM_NODES" ]; then
    echo "run via sbatch -N <nodes> ..." >&2
    exit 1
fi

./multigpu_musica.sh $@

