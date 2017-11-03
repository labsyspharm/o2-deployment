#!/usr/bin/env bash

APP_PATH=$1
GIT_URL=$2

# Create the directory
mkdir -p ${APP_PATH}

# Load the python modules
module load gcc python

# Create a virtual environment
virtualenv ${APP_PATH}/venv

# Activate the virtual environment
source ${APP_PATH}/venv/bin/activate

# Upgrade pip
pip install -U pip

# Install omero-scripts
pip install ${GIT_URL}

module unload python gcc
