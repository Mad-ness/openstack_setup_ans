#!/bin/bash

state_file="$1"
env_file="$2"
project_name="$3"
domain_name="$4"
project_desc="$5"

echo "$env_file"

#if [ -f "$env_file" ]; then
    source "$env_file"    
source ~/.keystone.rc
#else
#    echo "Environment variables for password-based authentication are not found."
#    exit 1
#fi


openstack project show "$project_name" || openstack project create \
    --domain "$domain_name" \
    --description "$project_desc" \
    "$project_name"

op_code=$?

#if [ $? -eq 0 ]; then
#    d_path=`realpath $state_file`
#    test -d "$d_path" || mkdir "$d_path"
#    touch "$state_file"
#fi

exit $op_code

