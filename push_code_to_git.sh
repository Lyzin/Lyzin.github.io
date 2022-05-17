#!/bin/bash
#
#********************************************************************
#      Author:  刘阳
#        Date:  2022-05-17 22时33分24秒
#    FileName:  gitpushcode.sh
# Description:  The test script
#********************************************************************
#

current_path=$(pwd)
theme_name="themes"


function runstatus() {
    if [ $? -eq 0 ]
        then
            echo "\033[1;32mSUCCESS\033[0m"
    else
            echo "\033[1;31mFAILED\033[0m"
            exit 1
    fi
}

function addFileToGit() {
    for i in $(ls ${current_path})
    do
        if [ -d $i ]
        then
            if [ $i = ${theme_name} ]
            then
                echo "添加${theme_name}/butterfly/"
                git add $i"/butterfly/"
                echo
            else
                echo "添加普通目录:$i/"
                git add $i"/"
                echo
            fi 
        else
            echo "添加文件:"$i
            git add $i
            echo
        fi
    done
}

function pushCodeToGit() {
    # 填写提交commit
    echo "\033[1;36m添加提交commit\033[0m"
    git commit -m "$*"
    printf "\033[1;36m添加提交commit: \033[0m"
    runstatus
    echo

    # 推送到远程
    echo "\033[1;36m推送到远程\033[0m"
    git push origin master
    printf "\033[1;36m推送到远程: \033[0m"
    runstatus
    echo
}

function hexoDeployCode() {
    # hexo 部署到gh-pages分支
    hexo clean && hexo deploy
}

function main() {
    if [ $# -gt 0 ]
        then
            # 添加文件
            addFileToGit

            # 提交代码
            pushCodeToGit $*

            # hexo 部署
            hexoDeployCode
    else
        echo "USAGE: sh $0 'commit message'"
        echo "example: sh $0 'first subimt'"
    fi
}

main $*

