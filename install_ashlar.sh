#!/usr/bin/env bash

APP_PATH=$1
GIT_URL=$2
MINICONDA_URL=$3
CONDA_PATH=${1}/miniconda2

# Create the directory
mkdir -p ${APP_PATH}

# Load the modules
module load gcc python java fftw/3.3.6-pl1-multiple_precision

# Create a virtual environment
virtualenv ${APP_PATH}/venv

# Activate the virtual environment
source ${APP_PATH}/venv/bin/activate

# Set CFLAGS and LDFLAGS
export CFLAGS="$CFLAGS -I/n/app/fftw/3.3.6_pl1-multiple_precision/include/"
export LDFLAGS="$LDFLAGS -L/n/app/fftw/3.3.6_pl1-multiple_precision/lib/"

# Install numpy and scipy up-front
pip install -q -U numpy
pip install -q -U scipy

# Install ASHLAR
pip install -q -U ${GIT_URL}

# Deactivate the virtual environment
deactivate

# Unload modules
module unload java fftw python gcc
