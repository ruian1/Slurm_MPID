#!/bin/bash

# This runs inside the container and builds the container
# We assume you did the first-time setup already

INFILE_LIST=$1
OUTDIR=$2
RUNID=$3
RUNID2=$4

echo "WORKDIR",$WORKDIR
echo "INFILE_LIST",$INFILE_LIST
echo "OUTDIR"=$OUTDIR
# go to the working directory

#cd $WORKDIR
echo $OUTDIR

source /usr/local/bin/thisroot.sh
cd /usr/local/share/dllee_unified
source ./configure.sh
source /usr/local/share/MPID_pytorch/setup.sh


inference_cfg_file=/cluster/kappa/90-days-archive/wongjiradlab/larbys/pubs/dlleepubs/downstream/Production_Config/cfg/network/inference_config_tufts_WC.cfg

mpid_torch_dir=/cluster/kappa/90-days-archive/wongjiradlab/ran/MPID_pytorch/uboone/

echo "in dir of ", $PWD 

for i in $(seq 0.9 0.01 1.1)
do
    echo "Welcome $i times"

    tmp_dir=/tmp/tmp_${RUNID}_${RUNID2}_${i}
    mkdir -p $tmp_dir
    cd $tmp_dir

    python ${mpid_torch_dir}/inference_pid_torch_dlmerger_WC_sys.py  ${INFILE_LIST} . ${inference_cfg_file} $i $OUTDIR/$i
    echo "in dir of ", $PWD 
    ls -lrth .
    mv ./multipid_out_*_WC.root $OUTDIR/$i
done
