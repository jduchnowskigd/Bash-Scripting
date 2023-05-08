#!/bin/bash

readonly ARGS=("$@")
operand=""
debug=0

while getopts "do:n" o; do
  case "${o}" in
    o)
      operand=$OPTARG
      ;;
    n)
      # Set counter to 1 and shift to ignore first three arguments passed to the script
      shift 3

      last=${ARGS[3]}
      # Loop over command line arguments until the last argument is reached
      for i in "${ARGS[@]:4:$((${#ARGS[@]}-3))}"
      do
        last=$(echo "$last $operand $i" | bc)
      done
      echo "$last"
      ;;
    d)
      debug=1
      ;;
  esac
done

if ((debug == 1))
then
  echo "User: $USER"
  echo "Script: $0"
  echo "Operation: $operand"
  numbers=("${ARGS[*]:3:$((${#ARGS[*]}-4))}")
  echo "Numbers: ${numbers[*]}"
fi

