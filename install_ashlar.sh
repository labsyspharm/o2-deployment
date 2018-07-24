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

# Install cython up-front
pip install -q -U cython

# Install numpy manually to avoid warnings from potential binary incompatability
pip install -q -I "numpy>=1.14,<1.15"

# Install ASHLAR
pip install -q -U ${GIT_URL}

# Deactivate the virtual environment
deactivate

# Unload modules
module unload java fftw python gcc
