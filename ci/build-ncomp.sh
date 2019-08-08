#!/bin/bash

set -e
set -eo pipefail

conda config --set always_yes true --set changeps1 false --set quiet true
conda install git
conda config --add channels conda-forge
git clone ${NCOMP_GIT_REPO}
cd ncomp
git checkout circleci
echo "conda env create -f ci/environment-dev-$(uname).yml --name ${NCOMP_ENV_NAME} --quiet"
conda env create -f ci/environment-dev-$(uname).yml --name ${NCOMP_ENV_NAME} --quiet
conda env list
source activate ${NCOMP_ENV_NAME}
autoreconf --install
./configure --prefix=${CONDA_PREFIX}
make install
