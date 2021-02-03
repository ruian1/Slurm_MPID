#!/bin/bash

# This runs inside the container and builds the container
# We assume you did the first-time setup already

OUTDIR=$1

echo "OUTDIR"=$OUTDIR


for i in $(seq 0.9 0.01 1.1)
do
   echo "Welcome $i times"
   echo $OUTDIR/$i
   #mkdir $OUTDIR/$i
   echo $i
done