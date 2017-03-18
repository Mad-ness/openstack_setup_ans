#!/bin/bash

state_file="$1"
env_file="$2"
domain_name="$3"
project_name="$4"
username="$5"
rolename="$6"

echo "$env_file"

#if [ -f "$env_file" ]; then
    source "$env_file"    
source ~/.keystone.rc
#else
#    echo "Environment variables for password-based authentication are not found."
#    exit 1
#fi


#openstack role show --domain "$domain_name" "$role_name" || openstack role create \
#    --domain "$domain_name"     \
#    "$role_name"
openstack role add --project "$project_name" --project-domain "$domain_name" \
    --user "$username" "$rolename"

op_code=$?

#if [ $? -eq 0 ]; then
#    d_path=`realpath $state_file`
#    test -d "$d_path" || mkdir "$d_path"
#    touch "$state_file"
#fi

exit $op_code

