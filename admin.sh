#创建、修改、删除、显示（list）教师帐号；教师帐户包括教师工号、教师姓名，教师用户以教师工号登录。
#创建、修改、删除课程；绑定（包括添加、删除）课程与教师用户。课程名称以简单的中文或英文命名。

#! /bin/bash

#the two functions below judges whether the input id is valid
teacher_exits()
{
	echo "$tid"
	if [[ -n $(sed -n "/^$tid/p" teachers) ]]; then
		return 0
	else
		return 1
	fi
}
lecture_exits()
{
	echo "$lid"
	if [[ -n $(sed -n "/^$lid/p" lectures) ]]; then
		return 0
	else
		return 1
	fi
}

#funtion to bind teacher and lecture
bindTnL()
{
	echo "You are going to bind a teacher and a lecture"
	echo "Input lecture ID:"
	read lid

	#ID can only use a-z A-Z and number, other characters will be ignored
	lid=$(echo $lid | sed 's/[^a-zA-Z0-9]*//g')

	if lecture_exits "$lid"
	then
		echo "lid valid!"
	else
		echo  "lid not valid"
		sleep 1
		return 0
	fi

	echo "Input teacher ID:"
	read tid

	#ID can only use a-z A-Z and number, other characters will be ignored
	tid=$(echo $tid | sed 's/[^a-zA-Z0-9]*//g')

	if teacher_exits "$tid"
	then
		echo "tid valid!"
	else
		echo  "tid not valid"
		sleep 1
		return 0
	fi
	sleep 1

	while [[ true ]]; do
		echo "lecture: "$lid
		echo "teacher: "$tid
		echo "bind? (y/n)"
		read x
		case "$x" in
			y )
			#add a new line of record in the file lectures
			printf "$lid $tid\n">>teaches 
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

#function to unbind teacher and lecture
unbind()
{
	echo "You are going to unbind a teacher and a lecture"
	echo "Input lecture ID:"
	read lid

	#ID can only use a-z A-Z and number, other characters will be ignored
	lid=$(echo $lid | sed 's/[^a-zA-Z0-9]*//g')

	
	echo "Input teacher ID:"
	read tid

	#ID can only use a-z A-Z and number, other characters will be ignored
	tid=$(echo $tid | sed 's/[^a-zA-Z0-9]*//g')

	while [[ true ]]; do
		echo "lecture: "$lid
		echo "teacher: "$tid
		echo "bind? (y/n)"
		read x
		case "$x" in
			y )
			sed "/^$lid $tid/d" teaches>output
			mv -f output teaches
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

#function to add a lecture
addLecture()
{
	echo "You are going to add a lecture"
	echo "Input lecture ID:"
	read lid

	#ID can only use a-z A-Z and number, other characters will be ignored
	lid=$(echo $lid | sed 's/[^a-zA-Z0-9]*//g')
	echo "Input the lecture's name:"
	#the same as ID
	read lname
	lname=$(echo $lname | sed 's/[^a-zA-Z0-9]*//g')


	while [[ true ]]; do
		echo "Name: "$lname
		echo "ID: "$lid
		echo "Create the lecture? (y/n)"
		read x
		case "$x" in
			y )
			#add a new line of record in the file lectures
			printf "$lid $lname\n">>lectures 
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

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

#function to list all lectures
listLecture()
{
	echo "ID Name"
	echo "---------------"
	cat lectures
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

#function to delete a lecture
delLecture()
{
	echo "You are going to delete a lecture"
	echo "Input lecture ID:"
	read lid

	#ID can only use a-z A-Z and number, other characters will be ignored
	lid=$(echo $lid | sed 's/[^a-zA-Z0-9]*//g')

	while [[ true ]]; do
		echo "ID: "$lid
		echo "Delete the lecture? (y/n)"
		read x
		case "$x" in
			y )
			#remove the line from lectures
			sed "/^$lid /d" lectures>output
			mv -f output lectures
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
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
			sed "/^$tid/d" teachers>output
			mv -f output teachers
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
	echo "5 -- add a lecture"
	echo "6 -- delete a lecture"
	echo "7 -- list all lectures"
	echo "8 -- bind teacher and lecture"
	echo "9 -- unbind teacher and lecture"

	echo " "
	echo "0 -- Quit"
	read num

	case $num in
		1) addTeacher;;		
		2) echo "Not availible";;
		3) deleteTeacher;;
		4) listTeacher;;
		5) addLecture;;
		6) delLecture;;
		7) listLecture;;
		8) bindTnL;;
		9) unbind;;
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

