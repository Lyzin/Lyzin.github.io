#!/bin/bash
#
#********************************************************************
#      Author:  刘阳
#        Date:  2023-05-25 13时32分50秒
#    FileName:  change_user.sh
# Description:  The test script
#********************************************************************
#

git filter-branch --env-filter '
WRONG_EMAIL="liuyangbj01@kanyun.com"
NEW_NAME="zinly"
NEW_EMAIL="zinly@xxx.com"

if [ "$GIT_COMMITTER_EMAIL" = "$WRONG_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$NEW_NAME"
    export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$WRONG_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$NEW_NAME"
    export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

