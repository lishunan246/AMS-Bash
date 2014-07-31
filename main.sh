#! /bin/bash

clear

while [[ true ]]; do
	echo "Welcome"
	echo "Please login as"
	echo "1 -- admin"
	echo "2 -- teacher"
	echo "3 -- student"

	echo " "
	echo "0 -- Quit"
	read num

	case $num in
		1) bash admin.sh;;
		2) bash teacher.sh;;
		3) bash student.sh;;
		0) clear
		echo "Bye"
		
		while [[ true ]]; do
			exit
		done;;
		*) echo "Please input the right num"
		sleep 1
		clear;;

	esac
done