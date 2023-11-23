#!/bin/bash

for number in {1..5}; do

   if [ $((number % 2)) -eq 0 ]; then

       echo "$number is even."

   else

       echo "$number is odd."

   fi

done
