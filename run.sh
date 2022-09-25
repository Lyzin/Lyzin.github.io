#!/bin/bash
#
#********************************************************************
#      Author:  刘阳
#        Date:  2022-07-28 11时19分44秒
#    FileName:  run.sh
# Description:  The test script
#********************************************************************
#

IPAddr=$(ifconfig en0 | awk NR==5'{print $2}')


function runserver() {
    if [ $# -gt 0 ]
    then
        case $1 in
            l)
                hexo server
                ;;
            n)
                hexo server -i ${IPAddr}
                ;;
            *)
                echo "input error"
                exit 1
        esac
    else
        echo "Usage:sh $0 l(local)|n(network)"
    fi
}

runserver  $1

