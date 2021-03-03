#!/usr/bin/env bash

PREFIX=ARCH:
TOP="$(dirname "$0")"


export ARCHIVER_URL=http://pscaa02.slac.stanford.edu:17665/mgmt/ui/index.html
export ARCHSTATS_DATABASE=elastic
export ARCHSTATS_DATABASE_URL=ctl-logsrv01:9200

export ARCHSTATS_INDEX_FORMAT="archiver-appliance-stats"
export ARCHSTATS_INDEX_SUFFIX=""

export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST=172.21.95.255

export IOC_DATA_ARCH=/reg/d/iocData/ioc-archstats
export LOG_FILE_PATH=${IOC_DATA_ARCH}/ioc.log

unset LD_LIBRARY_PATH
unset PYTHONPATH

##########################################
# currently unused:
# export PCDS_CONDA_VER='3.2.0'
source /reg/g/pcds/pyps/conda/pcds_conda

CONDA_ENV=$PWD/conda_env
##########################################

run_ioc() {
    conda activate $CONDA_ENV
    echo ""
    echo "* Running the IOC..."
    set -ex
    cd ${TOP}
    python --version
    archstats --prefix "${PREFIX}" --list-pvs
}

(run_ioc 2>&1) | tee --append $LOG_FILE_PATH
