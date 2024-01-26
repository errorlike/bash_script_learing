#! /usr/bin/env bash
#  Check to make sure the user has entered exactly two agruments.
if [ $# -ne 2 ]; then
    echo "Usage: backup.sh <souce_directory> <targe_directory>"
    echo "Please try again."
    exit 1
fi

# Check to see if rsync is installed.
if ! command -v rsync &>/dev/null; then
    ehco "This script requires rsync to be installed."
    echo "Please user your distribution's package manager to install it and try again"
    exit 2
fi

current_date=$(date +%Y-%m-%d)
# -a 选项表示archive模式，它会保持文件的所有属性，包括所有者、组、权限等。
# -v 选项表示verbose模式，它会显示详细的输出，让你知道rsync在做什么。
# -b 选项表示备份模式，它会让rsync在覆盖文件之前先将原文件备份到指定的目录。
# --backup-dir 选项后面需要指定一个目录，用来存放rsync在覆盖文件时所做的备份

# --delete 同步delete的文件
#  --dry-run 试运行
rsync_options="-avb --backup-dir $2/$current_date --delete "

$(which rsync) "$rsync_options $1 $2/current" >>"backup_$current_date.log"
