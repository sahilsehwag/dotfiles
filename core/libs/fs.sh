#--------------------------------------------------------------------#
#																CHECKS															 #
#--------------------------------------------------------------------#
F_isFile() {
	local file=$1
	if [[ -f "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isDir() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		return 0
	else
		return 1
	fi
}

F_isExecutable() {
	local file=$1
	if [[ -x "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isReadable() {
	local file=$1
	if [[ -r "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isWritable() {
	local file=$1
	if [[ -w "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isSoftlink() {
	local file=$1
	if [[ -L "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isHardlink() {
	local file=$1
	if [[ -h "$file" ]]; then
		return 0
	else
		return 1
	fi
}

F_isLink() {
	local file=$1
	if F_isSoftlink "$file" || F_isHardlink "$file"; then
		return 0
	else
		return 1
	fi
}

F_isMounted() {
	local file=$1
	if [[ -n "$(mount | grep $file)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isBinFile() {
	local file=$1
	if [[ -n "$(file $file | grep 'executable')" ]]; then
		return 0
	else
		return 1
	fi
}

F_isTextFile() {
	local file=$1
	if [[ -n "$(file $file | grep 'text')" ]]; then
		return 0
	else
		return 1
	fi
}

F_isFileEmpty() {
	local file=$1
	if [[ -f "$file" ]]; then
		if [[ -s "$file" ]]; then
			return 1
		else
			return 0
		fi
	else
		return 1
	fi
}

F_isDirEmpty() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		if [[ "$(ls -A $dir)" ]]; then
			return 1
		else
			return 0
		fi
	else
		return 1
	fi
}

F_hasExt() {
	local ext=$1
	local file=$2
	if [[ -n "$(echo $file | grep $ext)" ]]; then
		return 0
	else
		return 1
	fi
}

F_hasPerm() {
	local perm=$1
	local file=$2
	if [[ -n "$(stat -c %a $file | grep $perm)" ]]; then
		return 0
	else
		return 1
	fi
}

F_hasOwner() {
	local owner=$1
	local file=$2
	if [[ -n "$(stat -c %U $file | grep $owner)" ]]; then
		return 0
	else
		return 1
	fi
}

F_hasGrp() {
	local group=$1
	local file=$2
	if [[ -n "$(stat -c %G $file | grep $group)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isBinaryInstalled() {
	local package=$1
	if type $package &> /dev/null
	then
		return 0
	else
		return 1
	fi
}

F_isRunning() {
	local service=$1
	if [[ -n "$(systemctl is-active $service)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isEnabled() {
	local service=$1
	if [[ -n "$(systemctl is-enabled $service)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isSudo() {
	if [[ -n "$(sudo -v)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isRoot() {
	if [[ "$(whoami)" == "root" ]]; then
		return 0
	else
		return 1
	fi
}
#--------------------------------------------------------------------#
#																CHECKS															 #
#--------------------------------------------------------------------#

#--------------------------------------------------------------------#
#													 FILE-INFORMATION													 #
#--------------------------------------------------------------------#
F_getFileSize() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %s $file)
	fi
}

F_getFileOwner() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %U $file)
	fi
}

F_getFileGrp() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %G $file)
	fi
}

F_getFilePerm() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %a $file)
	fi
}

F_getFileModTime() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %y $file)
	fi
}

F_getFileCreationTime() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %z $file)
	fi
}

F_getFileType() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %F $file)
	fi
}

F_getFileMode() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %F $file)
	fi
}

F_getFileLink() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %F $file)
	fi
}

F_getFileInode() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(stat -c %i $file)
	fi
}
#--------------------------------------------------------------------#
#													 FILE-INFORMATION													 #
#--------------------------------------------------------------------#


#--------------------------------------------------------------------#
#												DIRECTORY-INFORMATION												 #
#--------------------------------------------------------------------#
F_getDirSize() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(du -s $dir | awk '{print $1}')
	fi
}

F_getDirOwner() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %U $dir)
	fi
}

F_getDirGrp() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %G $dir)
	fi
}

F_getDirPermission() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %a $dir)
	fi
}

F_getDirModificationTime() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %y $dir)
	fi
}

F_getDirCreationTime() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %z $dir)
	fi
}

F_getDirType() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %F $dir)
	fi
}

F_getDirMode() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %F $dir)
	fi
}

F_getDirLink() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %F $dir)
	fi
}

F_getDirInode() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		echo $(stat -c %i $dir)
	fi
}
#--------------------------------------------------------------------#
#												DIRECTORY-INFORMATION												 #
#--------------------------------------------------------------------#

#--------------------------------------------------------------------#
#															 HASHING															 #
#--------------------------------------------------------------------#
F_getFileHash() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(md5sum $file | awk '{print $1}')
	fi
}

F_getFileHashSHA1() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(sha1sum $file | awk '{print $1}')
	fi
}

F_getFileHashSHA256() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(sha256sum $file | awk '{print $1}')
	fi
}

F_getFileHashSHA512() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(sha512sum $file | awk '{print $1}')
	fi
}

F_getFileHashMD5() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(md5sum $file | awk '{print $1}')
	fi
}

F_getFileHashCRC32() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(crc32 $file | awk '{print $1}')
	fi
}

F_getFileHashCRC64() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(crc64 $file | awk '{print $1}')
	fi
}

F_getFileHashCRC64ECMA() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(crc64ecma $file | awk '{print $1}')
	fi
}

F_getFileHashAdler32() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(adler32 $file | awk '{print $1}')
	fi
}

F_getFileHashAll() {
	local file=$1
	if [[ -f "$file" ]]; then
		echo $(md5sum $file | awk '{print $1}')
		echo $(sha1sum $file | awk '{print $1}')
		echo $(sha256sum $file | awk '{print $1}')
		echo $(sha512sum $file | awk '{print $1}')
		echo $(md5sum $file | awk '{print $1}')
		echo $(crc32 $file | awk '{print $1}')
		echo $(crc64 $file | awk '{print $1}')
		echo $(crc64ecma $file | awk '{print $1}')
		echo $(adler32 $file | awk '{print $1}')
	fi
}
#--------------------------------------------------------------------#
#															 HASHING															 #
#--------------------------------------------------------------------#

#--------------------------------------------------------------------#
#													 FILE-OPERATIONS													 #
#--------------------------------------------------------------------#
F_readFile() {
	local file=$1
	if [[ -f "$file" ]]; then
		cat $file
	fi
}

F_readLine() {
	local line=$1
	local file=$2
	if [[ -f "$file" ]]; then
		sed -n "$line"p $file
	fi
}

F_readLines() {
	local from=$1
	local to=$2
	local file=$3
	if [[ -f "$file" ]]; then
		sed -n "$from,$to"p $file
	fi
}

F_readLinesFrom() {
	local from=$1
	local file=$2
	if [[ -f "$file" ]]; then
		sed -n "$from,$"p $file
	fi
}

F_readLinesTo() {
	local to=$1
	local file=$2
	if [[ -f "$file" ]]; then
		sed -n "1,$to"p $file
	fi
}

F_readLinesRegex() {
	local regex=$1
	local file=$2
	if [[ -f "$file" ]]; then
		rg "$regex" $file | choose 1
	fi
}

F_readLinesRegexNot() {
	local regex=$1
	local file=$2
	if [[ -f "$file" ]]; then
		rg -v "$regex" $file | choose 1
	fi
}

F_appendToFile() {
	local file=$1
	local text=$2
	echo $text >> $file
}

F_prependToFile() {
	local file=$1
	local text=$2
	echo $text > $file
}

F_delLines() {
	local pattern=$1
	local file=$2
	grep -iv "$pattern" $file > /tmp/backup && mv /tmp/backup $file
	#sed -i "/$pattern/d" "$file"
	#rg -iv "$pattern" $file > /tmp/backup && mv /tmp/backup $file
}

#--------------------------------------------------------------------#
#													 FILE-OPERATIONS													 #
#--------------------------------------------------------------------#


#--------------------------------------------------------------------#
#												 DIRECTORY-OPERATIONS												 #
#--------------------------------------------------------------------#
F_createDir() {
	local dir=$1
	if [[ ! -d "$dir" ]]; then
		mkdir -p $dir
	fi
}

F_deleteDir() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		rm -rf $dir
	fi
}

F_listDir() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		ls -a1 $dir
	fi
}

F_listDirRecursive() {
	local dir=$1
	if [[ -d "$dir" ]]; then
		find $dir -type f
	fi
}
#-------------------------------------------------------------------#
#												 DIRECTORY-OPERATIONS												 #
#--------------------------------------------------------------------#



#--------------------------------------------------------------------#
#																 PORT																 #
#--------------------------------------------------------------------#
F_isPortOpen() {
	local port=$1
	if [[ -n "$(netstat -tulpn | grep $port)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortListening() {
	local port=$1
	if [[ -n "$(netstat -tulpn | grep LISTEN | grep $port)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortConnected() {
	local port=$1
	if [[ -n "$(netstat -tulpn | grep ESTABLISHED | grep $port)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortForwarded() {
	local port=$1
	if [[ -n "$(netstat -tulpn | grep $port)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortReachable() {
	local port=$1
	if [[ -n "$(nc -z localhost $port)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortReachableBy() {
	local port=$1
	local protocol=$2
	if [[ -n "$(nc -z localhost $port $protocol)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortReachableByUser() {
	local port=$1
	local protocol=$2
	local user=$3
	if [[ -n "$(nc -z localhost $port $protocol | grep $user)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortReachableByGrp() {
	local port=$1
	local protocol=$2
	local group=$3
	if [[ -n "$(nc -z localhost $port $protocol | grep $group)" ]]; then
		return 0
	else
		return 1
	fi
}

F_isPortReachableByUserGrp() {
	local port=$1
	local protocol=$2
	local user=$3
	local group=$4
	if [[ -n "$(nc -z localhost $port $protocol | grep $user | grep $group)" ]]; then
		return 0
	else
		return 1
	fi
}
#--------------------------------------------------------------------#
#																 PORT																 #
#--------------------------------------------------------------------#

#--------------------------------------------------------------------#
#																 LINK																 #
#--------------------------------------------------------------------#

F_createSoftLink() {
	ln -sv $1 $2
}

F_createHardLink() {
	ln -v $1 $2
}

#--------------------------------------------------------------------#
#																 LINK																 #
#--------------------------------------------------------------------#

