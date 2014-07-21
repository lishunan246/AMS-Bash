#! /bin/bash

while [[ true ]]; do
	echo "Welcome"
	echo "Please login"

	read num

	case $num in
		1) echo 1
			;;
		0) clear
		echo "Bye"
		sleep 1
		while [[ true ]]; do
			exit
		done;;
		*) echo "Please input the right num"
		sleep 1
		clear;;

	esac
done