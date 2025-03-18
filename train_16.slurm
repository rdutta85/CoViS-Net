#!/bin/bash
#SBATCH --mail-user=rishavdutta@umass.edu
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --cpus-per-gpu 8  # Number of Cores per Task
#SBATCH -p gpu
#SBATCH --mem-per-cpu=8GB
#SBATCH -t 24:00:00  # Job time limit
#SBATCH -o ./slurm/slurm-datasets-%j.out  # %j = job ID
#SBATCH --gres=gpu:4
#SBATCH --gpus=4
#SBATCH --constraint=a40|l40s
#SBATCH -A pi_hzhang2_umass_edu

cd /work/pi_hzhang2_umass_edu/rishavdutta_umass_edu/git_repos_hcr/CoViS-Net

module load conda/latest
module load cudnn/8.9.7.29-12-cuda12.6
conda activate covisnet
source pre_training_setup.bash

source ~/miniconda3/etc/profile.d/conda.sh conda activate sound
cd /scratch3/workspace/suyoungkang_umass_edu-l48
python3 -m train fit --config train/configs/covisnet.yaml --config train/configs/logging.yaml --data.batch_size 16 --data.num_workers 8

