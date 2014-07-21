#创建、修改、删除、显示（list）教师帐号；教师帐户包括教师工号、教师姓名，教师用户以教师工号登录。
#创建、修改、删除课程；绑定（包括添加、删除）课程与教师用户。课程名称以简单的中文或英文命名。

#! /bin/bash

#function to create a teacher account
addTeacher()
{
	echo "You are going to add a teacher account"
	echo "Input teacher ID:"
	read tid

	#ID can only use a-z A-Z and number, other characters will be ignored
	tid=$(echo $tid | sed 's/[^a-zA-Z0-9]*//g')
	echo "Input teacher's name:"
	#the same as ID
	read tname
	tname=$(echo $tname | sed 's/[^a-zA-Z0-9]*//g')


	while [[ true ]]; do
		echo "Name: "$tname
		echo "ID: "$tid
		echo "Create the account? (y/n)"
		read x
		case "$x" in
			y )
			#add a new line of record in the file teachers
			printf "$tid $tname\n">>teachers 
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

#function to list all teachers
listTeacher()
{
	echo "ID Name"
	echo "---------------"
	cat teachers
	echo "---------------"
	echo "Enter q to quit"

	while [[ true ]]; do
		read x
		case "$x" in
			q) clear 
			return 1;;
			
			*);;
		esac
	done
}

#function to delete a teacher account
deleteTeacher()
{
	echo "You are going to delete a teacher account"
	echo "Input teacher ID:"
	read tid

	#ID can only use a-z A-Z and number, other characters will be ignored
	tid=$(echo $tid | sed 's/[^a-zA-Z0-9]*//g')
	


	while [[ true ]]; do
		echo "ID: "$tid
		echo "Delete the account? (y/n)"
		read x
		case "$x" in
			y )
			#remove the line from teachers
			#sed "/^\"$tid\" /d" teachers
			sed "/^$tid /d" teachers>teachers
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

while [[ true ]]; do
	clear
	echo "Welcome, Admin"
	echo "What do you want to do?"
	echo "1 -- create a teacher account"
	echo "2 -- modify a teacher account"
	echo "3 -- delete a teacher account"
	echo "4 -- list all teacher accounts"

	echo " "
	echo "0 -- Quit"
	read num

	case $num in
		1) addTeacher;;
		2) bash teacher.sh;;
		3) deleteTeacher;;
		4) listTeacher;;
		0) clear
		
		sleep 1
		while [[ true ]]; do
			exit
		done;;
		*) echo "Please input the right num"
		sleep 1
		clear;;

	esac
done

