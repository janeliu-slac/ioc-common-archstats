#!/bin/bash

conda create -p $PWD/conda_env python=3.7
conda activate $PWD/conda_env

pip install -r archstats/requirements.txt

cd archstats && pip install -e .
