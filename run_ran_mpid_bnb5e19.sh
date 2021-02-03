#!/bin/bash

# sample name
SAMPLE=mcc9jan_bnb5e19

# where the selection scripts live
SELECT_DIR=/cluster/tufts/wongjiradlab/twongj01/1L1PSelection/

# files to run
FILELIST=$SELECT_DIR/filelists/dlreco_$SAMPLE.txt

# files to run per job
NFILES=100
CONTAINER=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_ubdl_deps_py2_10022019.simg

# DLLEE UNIFIED REPO location
DLLEE_DIR=/cluster/tufts/wongjiradlab/twongj01/production/dllee_unified_opencv3.1_copy2

# final output dir
#FINAL_OUT_DIR=$SELECT_DIR/out_$SAMPLE
FINAL_OUT_DIR=out_$SAMPLE
mkdir -p $FINAL_OUT_DIR

# for debug (slurm will set this up for us automatically if we use the array argument)
#SLURM_ARRAY_TASK_ID=10

# define start and end lines in filelist to run

echo $SLURM_ARRAY_TASK_ID

let start=$NFILES*$SLURM_ARRAY_TASK_ID+1
let end=$NFILES*${SLURM_ARRAY_TASK_ID}+$NFILES

# get list of files
sed -n ${start},${end}p $FILELIST > runlist.txt