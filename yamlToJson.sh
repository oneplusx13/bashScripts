#!/bin/bash

# convert a yaml file to json format

# exit on fail
set -e

# Check for file
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.yaml>"
    exit 1
fi

# yaml file
INPUT_FILE="$1"

# make sure file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# set output file name - same basename different extension
OUTPUT_FILE="${INPUT_FILE%.*}.json"

# use Python
python3 - <<EOF
import sys, json, yaml

# Yaml
with open("$INPUT_FILE", "r") as f:
    data = yaml.safe_load(f)

# create json file
with open("$OUTPUT_FILE", "w") as f:
    json.dump(data, f, indent=4)

print(f"✅ Converted '$INPUT_FILE' → '$OUTPUT_FILE'")
EOF
