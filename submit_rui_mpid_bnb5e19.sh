#!/bin/bash
#
#SBATCH --job-name=mpid-ran-bnb5e19
#SBATCH --time=120:00
#SBATCH --mem-per-cpu=2000
#SBATCH --array=0-137

source run_rui_FVV_bnb5e19.sh