#!/bin/bash
# -------------------------------------------
# yaml_to_json.sh
# A simple script to convert YAML → JSON
# -------------------------------------------

# Exit immediately if any command fails
set -e

# Check that a filename argument was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.yaml>"
    exit 1
fi

# Input YAML file
INPUT_FILE="$1"

# Verify that the file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# Build output filename by replacing .yaml/.yml with .json
OUTPUT_FILE="${INPUT_FILE%.*}.json"

# Run Python inline to convert YAML → JSON
python3 - <<EOF
import sys, json, yaml

# Read YAML file
with open("$INPUT_FILE", "r") as f:
    data = yaml.safe_load(f)

# Write JSON output
with open("$OUTPUT_FILE", "w") as f:
    json.dump(data, f, indent=4)

print(f"✅ Converted '$INPUT_FILE' → '$OUTPUT_FILE'")
EOF
