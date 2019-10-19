#!/bin/bash

# This code is developed at Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license.
#
# Code is copied from Stack Overflow.
#
# Stack Overflow question: https://stackoverflow.com/q/28320134
# Question author: Johan (https://stackoverflow.com/users/398441/johan)
#
# Stack Overflow answer with this code: https://stackoverflow.com/a/39454426
# Answer author: Vi.Ci (https://stackoverflow.com/users/6382035/vi-ci)
#
# Modified by hrakup (https://stackoverflow.com/users/4542932/hrakup) (added Extended RegExp option to grep)

if [ $# -lt 1 ]
then
cat << HELP

dockertags  --  list all tags for a Docker image on a remote registry.

EXAMPLE: 
    - list all tags for ubuntu:
       dockertags.sh ubuntu

    - list all php tags containing apache:
       dockertags.sh php apache

HELP
fi

image="$1"
tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`

if [ -n "$2" ]
then
    tags=` echo "${tags}" | grep -E "$2" `
fi

echo "${tags}"
