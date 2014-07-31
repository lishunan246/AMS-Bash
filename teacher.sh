#对某门课程，创建或导入、修改、删除学生帐户，根据学号查找学生帐号；学生帐号的基本信息包括学号和姓名，学生使用学号登录。
#发布课程信息。包括新建、编辑、删除、显示（list）课程信息等功能。
#布置作业或实验。包括新建、编辑、删除、显示（list）作业或实验等功能。
#查找、打印所有学生的完成作业情况。

lecture_exits()
{
	echo "$lid"
	if [[ -n $(sed -n "/^$lid/p" lectures) ]]; then
		return 0
	else
		return 1
	fi
}

teacher_exits()
{
	echo "$tid"
	if [[ -n $(sed -n "/^$tid/p" teachers) ]]; then
		return 0
	else
		return 1
	fi
}


addHomework()
{
	if [[ -d $(echo $tid"_"$lid"_files") ]]; then
		#statements
		echo "ok">/dev/null
	else
		mkdir  $(echo $tid"_"$lid"_files")
	fi

	filename=$(echo $tid"_"$lid"_homework")

	if [[ -e $filename ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi

	echo "You are going to add a entry of homework"
	echo "Input homework ID:"
	read hid

	#ID can only use a-z A-Z and number, other characters will be ignored
	hid=$(echo $hid | sed 's/[^a-zA-Z0-9]*//g')
	echo "Input homework name:"
	#the same as ID
	read hname
	hname=$(echo $hname | sed 's/[^a-zA-Z0-9]*//g')


	while [[ true ]]; do
		echo "Name: "$hname
		echo "ID: "$hid
		echo "Create the entry? (y/n)"
		read x
		case "$x" in
			y )
			#add a new line of record in the file teachers
			printf "$hid $hname\n">>$filename 
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

addStudent()
{
	filename=$(echo $tid"_"$lid"_students")

	if [[ -e $(echo $tid"_"$lid"_students") ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi

	echo "You are going to add a student account"
	echo "Input student ID:"
	read sid

	#ID can only use a-z A-Z and number, other characters will be ignored
	sid=$(echo $sid | sed 's/[^a-zA-Z0-9]*//g')
	echo "Input student's name:"
	#the same as ID
	read sname
	sname=$(echo $sname | sed 's/[^a-zA-Z0-9]*//g')


	while [[ true ]]; do
		echo "Name: "$sname
		echo "ID: "$sid
		echo "Create the account? (y/n)"
		read x
		case "$x" in
			y )
			#add a new line of record in the file teachers
			printf "$sid $sname\n">>$filename 
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

listStudent()
{
	filename=$(echo $tid"_"$lid"_students")

	if [[ -e $(echo $tid"_"$lid"_students") ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi
	echo "ID Name"
	echo "---------------"
	cat $(echo $tid"_"$lid"_students")
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

listHomework()
{
	if [[ -d $(echo $tid"_"$lid"_files") ]]; then
		#statements
		echo "ok">/dev/null
	else
		mkdir  $(echo $tid"_"$lid"_files")
	fi

	filename=$(echo $tid"_"$lid"_homework")

	if [[ -e $filename ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi
	echo "ID Name"
	echo "---------------"
	cat $filename
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

delHomework()
{

	filename=$(echo $tid"_"$lid"_homework")

	if [[ -e $filename ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi
	echo "You are going to delete an entry of homework"
	echo "Input homework ID:"
	read hid

	#ID can only use a-z A-Z and number, other characters will be ignored
	hid=$(echo $hid | sed 's/[^a-zA-Z0-9]*//g')

	while [[ true ]]; do
		echo "ID: "$hid
		echo "Delete the account? (y/n)"
		read x
		case "$x" in
			y )
			#remove the line from teachers
			sed "/^$hid /d" $filename>output
			mv -f output $filename
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done
}

delStudent()
{
	filename=$(echo $tid"_"$lid"_students")

	if [[ -e $(echo $tid"_"$lid"_students") ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi
	echo "You are going to delete a student account"
	echo "Input student ID:"
	read sid

	#ID can only use a-z A-Z and number, other characters will be ignored
	sid=$(echo $sid | sed 's/[^a-zA-Z0-9]*//g')

	while [[ true ]]; do
		echo "ID: "$sid
		echo "Delete the account? (y/n)"
		read x
		case "$x" in
			y )
			#remove the line from teachers
			sed "/^$sid /d" $filename>output
			mv -f output $filename
			echo "OK"
			sleep 1
			return	1;;
			n ) return 0;;
			*) echo "Answer y or n"
		esac
		sleep 1
	done

}

modifyInfo()
{
	if [[ -e  $(echo $tid"_"$lid"_info") ]]; then
		echo "current lecture info is"
		cat $(echo $tid"_"$lid"_info")
		echo "Press to continue"
		read nothing
	else
		touch $(echo $tid"_"$lid"_info")
		echo "current lecture info is"
		cat $(echo $tid"_"$lid"_info")
		echo "Press to continue"
		read nothing
	fi
		echo "Input  new lecture info:"

		read info
		echo $info>$(echo $tid"_"$lid"_info")
	
}

echo "Hello, Teacher"
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

while [[ true ]]; do
	clear
	echo "Welcome, teacher"
	echo "What do you want to do?"
	echo "1 -- modify lecture info"
	echo "2 -- add student"
	echo "3 -- delete student"
	echo "4 -- list all students"
	echo "5 -- add homework"
	echo "6 -- delete homework"
	echo "7 -- list homework"
	echo "8 -- list homework uploaded"
	echo "9 -- view a student's homework"

	echo " "
	echo "0 -- Quit"
	read num

	case $num in
		1) modifyInfo;;		
		2) addStudent;;
		3) delStudent;;
		4) listStudent;;
		5) addHomework;;
		6) delHomework;;
		7) listHomework;;
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