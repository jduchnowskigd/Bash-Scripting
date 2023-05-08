#!/bin/bash

echo "Which element of the Fibonacci sequence you want to see?"
read -r INDEX

fibonacci()
{
	current_number="$1"
	if ((current_number <= 1))
	 then 
	  echo "$current_number"
	else
	  echo $(( $(fibonacci $(("$current_number" -  1))) + $(fibonacci $(("$current_number" -  2)))))
	fi
}

fibonacci "$INDEX"
