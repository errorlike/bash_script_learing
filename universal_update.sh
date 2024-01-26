#! /usr/bin/env bash
release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

check_exit_status() {
    if [ "$?" -ne 0 ]; then
        echo "An error ocurred, Please check the $errorlog file"
    fi
}
if grep -q "Arch" $release_file; then
    # 主机基于arch系统
    sudo pacman -Syu >>$logfile 2>>$errorlog
    check_exit_status
fi

if grep -q "Ubuntu" $release_file || grep -q "Debian" $release_file; then
    # 主机基于Ubuntu系统
    sudo apt update >>$logfile 2>>$errorlog
    check_exit_status
    sudo apt dist-upgrade -y >>$logfile 2>>$errorlog
    check_exit_status
fi
