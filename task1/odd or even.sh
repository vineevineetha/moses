#!bin/bash
echo "enter the number:" number
read -p number
if ((number & 1 == 0)); then
	echo "$number is even."
else
	echo"$number is odd."
fi
