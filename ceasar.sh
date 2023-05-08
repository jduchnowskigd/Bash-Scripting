#!/bin/bash

shift_value=1
input_file=""
output_file=""
while getopts "s:i:o:" o; do
  case "${o}" in
    s)
      shift_value=$OPTARG
      ;;
    i)
     readonly input_file=$OPTARG
      ;;
    o)
     readonly output_file=$OPTARG
      ;;
  esac
done

readonly INPUT_STRING=$(cat "$input_file")

output_string=""
for (( i=0; i<${#INPUT_STRING}; i++ )); do
    CHAR=${INPUT_STRING:i:1}
    if [[ "$CHAR" =~ [A-Za-z] ]]; then
        ASCII_VAL=$(printf '%d' "'$CHAR")
        shifted_ascii_val=$((ASCII_VAL + shift_value))
        if [[ "$CHAR" =~ [A-Z] ]]; then
            if (( shifted_ascii_val > 90 )); then
                shifted_ascii_val=$((shifted_ascii_val - 26))
            fi
        else
            if (( shifted_ascii_val > 122 )); then
                shifted_ascii_val=$((shifted_ascii_val - 26))
            fi
        fi
        output_string+=$(printf "\\$(printf '%03o' "$shifted_ascii_val")")
       
    else
        output_string+="$CHAR"
    fi
done

echo "$output_string" > "$output_file"
