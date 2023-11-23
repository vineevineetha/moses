#!/bin/bash

factorial=1

for (( i=1; i<=5; i++ )); do

   factorial=$((factorial * i))

done

echo "Factorial of 5 is $factorial."
