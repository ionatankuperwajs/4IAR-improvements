#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=48
#SBATCH --time=96:00:00
#SBATCH --mem=48GB
#SBATCH --job-name=fourinarow
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ik1125@nyu.edu
#SBATCH --output=4inarow_%j.out

direc=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper/train
codedirec=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper
out_path=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper/fits/out${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2020b

echo "addpath(genpath('${codedirec}')); stochastic('${direc}', '${out_path}'); exit;" | matlab -nodisplay

echo "Done"

