############################################
### Example if no need to split inputlist###
############################################

#!/bin/bash

#SBATCH --job-name=mpid_rui_test
#SBATCH --output=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts/logs/mpid_rui_test/mpid_%x_%A_%a.out 
#SBATCH --error=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts/logs/mpid_rui_test/mpid_%x_%A_%a.err
#SBATCH --time=0-01:00:00
#SBATCH --mem-per-cpu=2000
#SBATCH --array=0-499
#SBATCH --nodes=1

SAMPLE=mcc9jan_extbnb
CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/ran/image/prod_dl_cpu_autoencoder_torch_mcc9.img
WORKDIR=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts
LIST_OF_LISTS=/cluster/kappa/90-days-archive/wongjiradlab/moon/1L1PSelection/filelists/dlreco_mcc9jan_extbnb.txt

let "proc_line=${SLURM_ARRAY_TASK_ID}+1+0"

outdir=$WORKDIR/out/$SLURM_JOB_NAME

mkdir -p $outdir

INFILE_LIST=`sed -n ${proc_line}p ${LIST_OF_LISTS}`

#echo ${SLURM_ARRAY_TASK_ID}
#echo ${SLURM_NTASKS_PER_CORE}
#echo $SLURM_NTASKS_PER_CPU
#echo $INFILE_LIST

#module load singularity
#singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source MakeFinalJob.sh ${WORKDIR} ${SLURM_ARRAY_TASK_ID} ${INFILE_LIST}"
module load singularity

singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source run_mpid.sh ${INFILE_LIST} $outdir ${SLURM_ARRAY_TASK_ID}"