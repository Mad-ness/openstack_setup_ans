#!/bin/bash

state_file="$1"
env_file="$2"
service_name="$3"
service_desc="$4"
service_type="$5"

echo "$env_file"

#if [ -f "$env_file" ]; then
    source "$env_file"    
source ~/.keystone.rc
#else
#    echo "Environment variables for password-based authentication are not found."
#    exit 1
#fi


openstack service show "$service_name" || openstack service create \
    --description "$service_desc" \
    --name "$service_name" \
    --enable \
    "$service_type"

op_code=$?

#if [ $? -eq 0 ]; then
#    d_path=`realpath $state_file`
#    test -d "$d_path" || mkdir "$d_path"
#    touch "$state_file"
#fi

exit $op_code

