#!/bin/bash

pipelineName= credentialsFile= concourseTarget=

while [ $# -gt 0 ]; do
  case $1 in
    -p | --pipeline-name )
      pipelineName=$2
      shift
      ;;
    -t | --target )
      concourseTarget=$2
      shift
      ;;
    -j | --job )
      jobName=$2
      shift
      ;;
    * )
      echo "Unrecognized option: $1" 1>&2
      exit 1
      ;;
  esac
  shift
done

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
export concourseTarget=${concourseTarget:-lite}
echo "Concourse API target ${concourseTarget}"
export pipelineName=${pipelineName:-`basename $DIR`}
echo "Pipeline Name ${pipelineName}"
export jobName=${jobName:-build}
echo "Job Name ${jobName}"


realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

usage() {
  me=$(basename ${0})
  echo "USAGE: ${me}"
  exit 1
}

pushd $DIR
  fly -t ${concourseTarget} trigger-job -j ${pipelineName}/${jobName}
  fly -t ${concourseTarget} watch -j ${pipelineName}/${jobName}
popd
