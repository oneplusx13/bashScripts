#!/bin/bash
# -------------------------------------------------
# yaml_to_jsonl.sh
# Convert YAML → JSONL (JSON Lines format)
# Each top-level item in YAML becomes one JSON line.
# -------------------------------------------------

set -e  # Exit immediately if a command fails

# Check for input argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.yaml>"
    exit 1
fi

INPUT_FILE="$1"

# Verify file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# Create output filename
OUTPUT_FILE="${INPUT_FILE%.*}.jsonl"

# Use inline Python to do the conversion
python3 - <<EOF
import sys, json, yaml

# Load YAML content
with open("$INPUT_FILE", "r") as f:
    data = yaml.safe_load(f)

# Normalize: wrap single object into list for consistency
if isinstance(data, dict):
    data = [data]

# Write JSONL file
with open("$OUTPUT_FILE", "w") as f:
    for item in data:
        json.dump(item, f)
        f.write("\n")

print(f"✅ Converted '$INPUT_FILE' → '$OUTPUT_FILE'")
EOF
