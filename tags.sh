#!/bin/bash

INPUT_FILE=""
OUTPUT_FILE=""
STR_TO_REPLACE=""
REPLACEMENT_STR=""
result=""

while getopts "i:o:vs:rlu" o; do
  case "${o}" in
    i)
      INPUT_FILE=$OPTARG
      ;;
    o)
      OUTPUT_FILE=$OPTARG
      ;;
  esac
done
result=$(cat "$INPUT_FILE")
OPTIND=0
while getopts "i:o:vs:rlu" o; do
  case "${o}" in
    v)
      result=$(echo "$result" | tr '[:upper:][:lower:]' '[:lower:][:upper:]')
      ;;
    s)
      IFS='/' read -r STR_TO_REPLACE REPLACEMENT_STR <<< "${OPTARG}"
      result="${result/$STR_TO_REPLACE/$REPLACEMENT_STR}"
      ;;
    r) 
      result=$(echo "$result" | rev)
      ;;
    l)
      result=$(echo "$result" | tr '[:upper:]' '[:lower:]')
      ;;
    u)
      result=$(echo "$result" | tr '[:lower:]' '[:upper:]')
      ;;
  esac
done
echo "$result" > "$OUTPUT_FILE"
