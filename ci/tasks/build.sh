#!/bin/sh

inputDir=  outputDir=

while [ $# -gt 0 ]; do
  case $1 in
    -i | --input-dir )
      inputDir=$2
      shift
      ;;
    -o | --output-dir )
      outputDir=$2
      shift
      ;;
    * )
      echo "Unrecognized option: $1" 1>&2
      exit 1
      ;;
  esac
  shift
done

error_and_exit() {
  echo $1 >&2
  exit 1
}

if [ ! -d "$inputDir" ]; then
  error_and_exit "missing input directory: $inputDir"
fi
if [ ! -d "$outputDir" ]; then
  error_and_exit "missing output directory: $outputDir"
fi
if [ -z "$packageName" ]; then
  error_and_exit "missing package name (from task parameters)"
fi

buildRoot=$PWD

mkdir gopath
export GOPATH=${buildRoot}/gopath
goPathSrc="${GOPATH}/src/$packageName"
mkdir -p $goPathSrc
cp -r $buildRoot/$inputDir/* $goPathSrc
cd $goPathSrc

glide install
go build -o $buildRoot/$outputDir/check ./check/cmd/check
go build -o $buildRoot/$outputDir/in ./in/cmd/in
go build -o $buildRoot/$outputDir/out ./out/cmd/out

cp $buildRoot/$inputDir/Dockerfile $buildRoot/$outputDir
