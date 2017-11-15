#!/usr/bin/env bash

APP_PATH=$1
GIT_URL=$2

# Create the directory
mkdir -p ${APP_PATH}

# Load the modules
module load gcc python java fftw/3.3.6-pl1

# Create a virtual environment
virtualenv ${APP_PATH}/venv

# Activate the virtual environment
source ${APP_PATH}/venv/bin/activate

# Upgrade pip
pip install -q -U pip

# Set CFLAGS and LDFLAGS
export CFLAGS="-I/n/app/fftw/3.3.6_pl1/include"
export LDFLAGS="-L/n/app/fftw/3.3.6_pl1/lib/"

# Install numpy and scipy up-front
pip install -q -U numpy
pip install -q -U scipy

# Install ASHLAR
pip install -q -U ${GIT_URL}

# Deactivate the virtual environment
deactivate

# Unload modules
module unload java fftw python gcc
