if [[ $# -ne 1 ]]; then
	echo "Can not have more than one argument!"
	exit 1
fi

if [[ $# -eq 0 ]]; then
	echo "Must have one argument!"
	exit 1
fi

if [[ -d "$1" ]]; then
	echo "Directory: $1"
else
	echo "Directory: $1 does not exists!"
	exit 1
fi
echo "Total size:"
du -sh $1|cut -f 1
echo "Number of regular file(s) in the directory:"
find $1 -type f|wc -l
echo "Number of directory(s) in the directory:"
find $1 -type d|wc -l
echo "Number of executable file(s) in the directory:"
find $1 -executable|wc -l

exit 0
