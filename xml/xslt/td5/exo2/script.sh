#!/usr/bin/env bash

# Show help message
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <output_file> <stylesheet.xsl> <input.xml>"
  echo "Applies the given XSLT stylesheet to the input XML and writes to output."
  exit 0
fi

# Ensure all arguments are provided
if [[ $# -ne 2 ]]; then
  echo "Error: Missing arguments."
  echo "Run '$0 -h' for usage."
  exit 1
fi

input=$1
output=$2

xsltproc --output "$output" "stylesheet.xslt" "$input"

