#!/bin/bash

ENV_DIR="./env"
REQUIREMENTS="requirements.txt"

function build_env() {
    virtualenv ${ENV_DIR}
    source ${ENV_DIR}/bin/activate
    if [ -a ${REQUIREMENTS} ]; then
        pip install -r ${REQUIREMENTS}
    fi
}

function run() {
    source ${ENV_DIR}/bin/activate
    which python
    $@
}

function clean() {
    rm -rf ${ENV_DIR}
}

function usage() {
    echo "Usage: $0 [build | run <py_script> | clean]"
}

if [[ -z $1 ]]; then
    #build_env
    usage
else
    if [[ $1 = 'build' ]]; then
        build_env
    elif [[ $1 = 'run' ]]; then
        run ${@:2}
    elif [[ $1 = "clean" ]]; then
        clean
    elif [[ $1 = "-h" || $1 = '--help' ]]; then
        usage
    else
        usage
    fi
fi
