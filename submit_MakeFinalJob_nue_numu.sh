#!/bin/bash

#SBATCH --job-name=ubcode-crop-jmills
#SBATCH --output=log-MakeFinal_nue_numu-jmills
#SBATCH --partition batch
#SBATCH --time=0-01:00:00
#SBATCH --mem-per-cpu=2000
#SBATCH --array=0-135


CONTAINER=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_ubdl_deps_py2_10022019.simg
WORKDIR=/cluster/tufts/wongjiradlab/jmills09/1L1PSelection_Updated
LIST_OF_LISTS=/cluster/tufts/wongjiradlab/jmills09/files_merged/dlmerged_lists/bnboverlay_nueintrinsics/list_of_bnboverlay_nueintrinsics_lists.txt
# INFILE_LIST=/cluster/tufts/wongjiradlab/jmills09/files_merged/transferred_files_ext2.txt
IN_ROOT_DIR=/cluster/tufts/wongjiradlab/larbys/data/mcc9



let "proc_line=${SLURM_ARRAY_TASK_ID}+1+0"

INFILE_LIST=`sed -n ${proc_line}p ${LIST_OF_LISTS}`
#FILEHEX=echo $FILEID | sed  -e 's/^.*gen2_//p'

module load singularity
singularity exec ${CONTAINER} bash -c "cd ${WORKDIR} && source MakeFinalJob_nue_numu.sh ${WORKDIR} ${SLURM_ARRAY_TASK_ID} ${INFILE_LIST} ${IN_ROOT_DIR}"
