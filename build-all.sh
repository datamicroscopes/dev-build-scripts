#! /bin/bash

# Run `. build-all.sh conda-env-name`


if [ "$#" -ne 1 ]
then
  echo "Please specify Conda environment name"
  exit 1
fi

conda create -n $1 cmake eigen3 anaconda cython
bash build-dist.sh $1
bash build-common.sh $1
bash build-kernels.sh $1
bash build-mm.sh $1
bash build-irm.sh $1
bash build-lda.sh $1