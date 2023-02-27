#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=24:00:00
#SBATCH --mem=48GB
#SBATCH --job-name=fourinarow
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ik1125@nyu.edu
#SBATCH --output=4inarow_%a.out

direc=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper/test/network_${SLURM_ARRAY_TASK_ID}.csv
params_path=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper/test_fits/out_params.csv
codedirec=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper
out_path=$SCRATCH/fourinarow/Model\ code/matlab\ wrapper/test_fits/out${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2020b
export MATLABPATH=$HOME/matlab-output

export MATLAB_PREFDIR=$TMPDIR/.matlab/R2020b/
mkdir $TMPDIR/.matlab
cp -r $HOME/.matlab/R2020b $TMPDIR/.matlab/R2020b
mkdir $TMPDIR/.matlab/local_cluster_jobs
mkdir $TMPDIR/.matlab/local_cluster_jobs/R2020b

echo "addpath(genpath('${codedirec}')); parpool($SLURM_CPUS_PER_TASK);test_model_single('${direc}', '${params_path}', '${out_path}'); exit;" | matlab -nodisplay

echo "Done"
