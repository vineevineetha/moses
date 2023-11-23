#!/bin/bash

read number

if [ $((number % 2)) -eq 0 ]; then

   echo " even number."

else

   echo "odd number."

fi
