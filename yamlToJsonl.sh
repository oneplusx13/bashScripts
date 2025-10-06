#!/bin/bash

# Convert a yaml file to json format

# exit on fail
set -e

# Check for input file
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.yaml>"
    exit 1
fi

INPUT_FILE="$1"

# Make sure file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# Set output file name - same basename with different extension
OUTPUT_FILE="${INPUT_FILE%.*}.jsonl"

# Use python
python3 - <<EOF
import sys, json, yaml

# Yaml
with open("$INPUT_FILE", "r") as f:
    data = yaml.safe_load(f)

# format
if isinstance(data, dict):
    data = [data]

# create json file
with open("$OUTPUT_FILE", "w") as f:
    for item in data:
        json.dump(item, f)
        f.write("\n")

print(f"✅ Converted '$INPUT_FILE' → '$OUTPUT_FILE'")
EOF
