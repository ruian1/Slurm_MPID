#!/bin/bash

#SBATCH --job-name=submit_mpid_dlreco_mcc9_v13_bnb_overlay_run1
#SBATCH --output=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts/logs/mpid_rui_test/mpid_%x_%A_%a.out 
#SBATCH --error=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts/logs/mpid_rui_test/mpid_%x_%A_%a.err
#SBATCH --time=0-02:00:00
#SBATCH --mem-per-cpu=2000
#SBATCH --array=0-319
#SBATCH --nodes=1

CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/ran/image/prod_dl_cpu_autoencoder_torch_mcc9.img
WORKDIR=/cluster/kappa/90-days-archive/wongjiradlab/ran/1L1PSelection/grid_scripts
LIST_OF_LISTS=/cluster/kappa/90-days-archive/wongjiradlab/moon/1L1PSelection/filelists/mpid_input/dlreco_mcc9_v13_bnb_overlay_run1.txt

let "proc_line=${SLURM_ARRAY_TASK_ID}+1+0"

outdir=$WORKDIR/out/$SLURM_JOB_NAME

mkdir -p $outdir

INFILE_LIST=`sed -n ${proc_line}p ${LIST_OF_LISTS}`

echo "SLURM_ARRAY_TASK_ID,", ${SLURM_ARRAY_TASK_ID}
echo ${SLURM_NTASKS_PER_CORE}
echo $SLURM_NTASKS_PER_CPU
echo $INFILE_LIST

#module load singularity
#singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source MakeFinalJob.sh ${WORKDIR} ${SLURM_ARRAY_TASK_ID} ${INFILE_LIST}"
module load singularity


lines=`wc -l $INFILE_LIST`
echo $lines
lines=$(< $INFILE_LIST wc -l)
echo $lines
line=0
while [ $line -lt $lines ]
do
  echo
  let line+=1
  THIS_FILE_ID=`sed -n ${line}p ${INFILE_LIST}`
  RELATIVE_PATH=${THIS_FILE_ID%/*}
  FILE_NAME=${THIS_FILE_ID##*/}
  echo $THIS_FILE_ID
  echo $RELATIVE_PATH
  echo ${FILE_NAME}
  #singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source run_mpid.sh ${INFILE_LIST} $outdir ${SLURM_ARRAY_TASK_ID}"
  singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source run_mpid.sh ${THIS_FILE_ID} $outdir ${SLURM_ARRAY_TASK_ID} ${line}"

done

