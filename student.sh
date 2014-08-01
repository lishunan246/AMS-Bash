#在教师添加学生账户后，学生就可以登录系统，并完成作业和实验。
#基本功能：新建、编辑作业或实验功能；查询作业或实验完成情况。

#function to judge whether the homework entry exits
homework_exits()
{
	filename=$(echo $tid"_"$lid"_homework")
	echo "$hid"
	if [[ -n $(sed -n "/^$hid /p" $filename) ]]; then
		return 0
	else
		return 1
	fi
}

#function to judge whether the lecture entry exits
lecture_exits()
{
	echo "$lid"
	if [[ -n $(sed -n "/^$lid/p" lectures) ]]; then
		return 0
	else
		return 1
	fi
}

#function to judge whether the teacher exits
teacher_exits()
{
	echo "$tid"
	if [[ -n $(sed -n "/^$tid/p" teachers) ]]; then
		return 0
	else
		return 1
	fi
}

#function to judge whether the student exits
student_exits()
{
	filename=$(echo $tid"_"$lid"_students")
	echo "$sid"
	if [[ -n $(sed -n "/^$sid /p" $filename) ]]; then
		return 0
	else
		return 1
	fi
}

#list all home work
listHomework()
{
	#create dir if not exists
	if [[ -d $(echo $tid"_"$lid"_files") ]]; then
		#statements
		echo "ok">/dev/null
	else
		mkdir  $(echo $tid"_"$lid"_files")
	fi

	filename=$(echo $tid"_"$lid"_homework")

	#create file if not exists

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

#view and edit your homework
editHomework()
{
	echo "Input homework ID"
	read hid

	if homework_exits
	then
		echo "tid valid!"
	else
		echo  "tid not valid"
		sleep 1
		return 0
	fi

	filename=$(echo $tid"_"$lid"_files/"$hid"_"$sid)

	if [[ -e $filename ]]; then
		echo "ok">/dev/null
	else
		touch $filename
	fi

	echo "Current homework result:"
	cat $filename
	echo "Input new result:"
	read input
	echo $input>$filename
}

echo "Hello, Student"
echo "Input your teacher's teacher ID:"
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

echo "Input lecture ID of the lecture you take:"
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


echo "Input  your student ID:"
read sid

#ID can only use a-z A-Z and number, other characters will be ignored
sid=$(echo $sid | sed 's/[^a-zA-Z0-9]*//g')

if student_exits "$sid"
then
	echo "sid valid!"
else
	echo  "sid not valid"
	sleep 1
	return 0
fi

while [[ true ]]; do
	clear
	echo "Welcome, student"
	echo "What do you want to do?"
	echo "1 -- list homework"
	echo "2 -- edit homework"

	echo " "
	echo "0 -- Quit"
	read num

	case $num in
		1) listHomework;;
		2) editHomework;;
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