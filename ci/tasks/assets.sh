#!/bin/sh

inputDir= outputDir=

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
  esac
  shift
done

error_and_exit() {
  echo $1 >&2
  exit 1
}

if [ ! -d "$inputDir" ]; then
  error_and_exit "missing output directory: $inputDir"
fi
if [ ! -d "$outputDir" ]; then
  error_and_exit "missing output directory: $outputDir"
fi

buildRoot=$PWD

cp $buildRoot/$inputDir/* $buildRoot/$outputDir
cd $buildRoot/$outputDir
curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
