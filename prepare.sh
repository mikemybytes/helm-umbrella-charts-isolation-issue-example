#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

bold=$(tput bold)
normal=$(tput sgr0)

function log() {
  echo "${bold}$1${normal}"
}

function prepare_scenario() {
    log "Preparing scenario '$1'"
    prepare_chart "$1/svc1"
    prepare_chart "$1/svc2"
    prepare_chart "$1/umbrella-chart"
}

function prepare_chart() {
  log "Preparing chart '$1'"
  (cd "$1" && rm -fr charts/ && helm dep update)
}

prepare_scenario "./installation-fails"
prepare_scenario "./installation-succeeds"