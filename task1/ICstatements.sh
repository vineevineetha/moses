#!/bin/bash
read -p "enter a number:" num
if [ $num -ge 0 ];then
echo "it is an positive number."
elif [ $num -le 0 ];then
echo "it is an negative number."
else
echo "it is an zero."
fi
