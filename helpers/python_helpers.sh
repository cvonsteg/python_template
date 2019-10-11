#!bin/bash

function init_venv() {
  venv_dir=$1
  python3.7 -m venv "$venv_dir"
  venv "$venv_dir"
  pip install wheel
  if [ -f requirements.txt ]; then
    pip install -r requirements.txt
  fi
  if [ -f requirements_dev.txt ]; then
    pip install -r requirements_dev.txt
  fi
}

function mkvenv() {
  venv_dir=${1:-.venv}
  if [ ! -d "$venv_dir" ]; then
    init_venv "$venv_dir" >&2
  fi
  echo "$venv_dir"
}

function venv() {
  venv_dir=$(mkvenv "$1")
  . $venv_dir/bin/activate
}

function pykernel() {
    if [ ! -a "$VIRTUAL_ENV" ]
    then 
        venv .venv
    fi
    default_name=${PWD##*/}
    pip install ipykernel
    ipython kernel install --user --name=${1:-$default_name}
}


