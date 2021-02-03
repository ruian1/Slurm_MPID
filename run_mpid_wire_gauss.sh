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

tmp_dir=/tmp/tmp_${RUNID}_${RUNID2}
mkdir $tmp_dir
cd $tmp_dir

inference_cfg_file=/cluster/kappa/90-days-archive/wongjiradlab/larbys/pubs/dlleepubs/downstream/Production_Config/cfg/network/inference_config_tufts_WC.cfg

mpid_torch_dir=/cluster/kappa/90-days-archive/wongjiradlab/ran/MPID_pytorch/uboone/

echo "in dir of ", $PWD 
python ${mpid_torch_dir}/inference_pid_torch_dlmerger_WC_wire_gauss.py  ${INFILE_LIST} . ${inference_cfg_file} $OUTDIR

echo "in dir of ", $PWD 
ls -lrth .
mv ./multipid_out_*_WC.root $OUTDIR
echo "WTF!!!!!!!!!!!!!!!!!!"