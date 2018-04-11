#!/usr/bin/env bash

APP_PATH=$1
GIT_URL=$2

# Create the directory
mkdir -p ${APP_PATH}

# Load the modules
module load gcc python java fftw

# Create a virtual environment
virtualenv ${APP_PATH}/venv

# Activate the virtual environment
source ${APP_PATH}/venv/bin/activate

# Upgrade pip
pip install -q -U pip

# Set CFLAGS and LDFLAGS
export CFLAGS="-I${C_INCLUDE_PATH}"
export LDFLAGS="-L${LD_LIBRARY_PATH}"

# Install cython up-front
pip install -q -U cython

# Install ASHLAR
pip install -q -U ${GIT_URL}

# Deactivate the virtual environment
deactivate

# Unload modules
module unload java fftw python gcc
