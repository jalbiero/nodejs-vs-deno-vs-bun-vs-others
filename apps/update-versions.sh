#!/usr/bin/env bash

# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

# Version updater: just edit the companion file "versions.txt", and
# after that, run this script.

# Note for macOS users: This script uses GNU sed which is the default
# version on Linux. If you plan to use it on macOS find the "sed" command
# at the end of this file and follow the instructions that are there.

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
templateFileExt="vtmpl"
readmeTemplate="template.md"
versionFile=$scriptDir/versions.txt

# Load variables to substitute
declare -A substVars
while read line; do
  if [[ $line != "" ]] && [[ ! $line =~ ^#.* ]]; then
    key="$(echo $line | cut -d'=' -f1)"
    value="$(echo $line | cut -d'=' -f2)"
    substVars[$key]=$value
  fi
done < $versionFile

# Find template files
find . -iname "*.$templateFileExt" -o -iname "*$readmeTemplate" | while read templateFile
do
  echo Processing $templateFile...

  # Remove template extension
  destinationFile=${templateFile%.$templateFileExt}

  # Backup destinationFile
  if [[ -f $destinationFile ]]; then
    cp -f $destinationFile ${destinationFile}.bak
  fi

  # Prepare file to be "edited"
  cp -f $templateFile $destinationFile

  for key in "${!substVars[@]}"; do
    value=${substVars[$key]}
    echo "--> Processing variable $key = $value"

    # For macOS comment the line below and uncomment the next one
    sed -i "s/\${$key}/$value/g" $destinationFile # GNU
    #sed -i '' -e "s/\${$key}/$value/g" $destinationFile # macOS
  done

done
