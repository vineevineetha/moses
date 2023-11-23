#!/bin/bash

read -p "enter number :" count

while [ $count -gt -1 ]; do

   echo "Count: $count"

   count=$((count - 1))

done
