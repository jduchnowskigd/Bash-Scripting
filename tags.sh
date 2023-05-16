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
      result=$(cat "$INPUT_FILE")
      ;;
    o)
      OUTPUT_FILE=$OPTARG
      ;;
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
    *) 
      echo "usage: $0 " >&2
      exit 1 ;;
  esac
done
echo "$result" > "$OUTPUT_FILE"
