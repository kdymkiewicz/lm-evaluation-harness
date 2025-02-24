#!/bin/bash
#SBATCH --job-name=lm_eval
#SBATCH --output=logs/lm_eval_%j.out
#SBATCH --error=logs/lm_eval_%j.err
#SBATCH --time=12:00:00
#SBATCH --gpus=2
#SBATCH --nodelist=ltl-gpu05

mkdir -p logs
bash run_script.bash