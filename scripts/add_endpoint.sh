#!/bin/bash

state_file="$1"
env_file="$2"
region="$3"
service_type="$4"
admin_url="$5"
internal_url="$6"
public_url="$7"

echo "$env_file"

#if [ -f "$env_file" ]; then
    source "$env_file"    
source ~/.keystone.rc
#else
#    echo "Environment variables for password-based authentication are not found."
#    exit 1
#fi

function endpoint_exists() {
    service_type="$1"
    interface="$2"
    openstack endpoint list | awk '
    {
        if ($12 == "'$interface'" && $8 == "'$service_type'") { sum+=1; } 
    } END {
        if (sum==1) exit(0); else exit(1)
    }
    ';
    return $?
}

endpoint_exists "$service_type" "admin"
if [ $? -ne 0 ]; then
    openstack endpoint create --region "$region" "$service_type" "admin" "$admin_url"
fi

if [ $? -ne 0 ]; then exit 1; fi

endpoint_exists "$service_type" "internal"
if [ $? -ne 0 ]; then
    openstack endpoint create --region "$region" "$service_type" "internal" "$internal_url"
fi

if [ $? -ne 0 ]; then exit 1; fi

endpoint_exists "$service_type" "public"
if [ $? -ne 0 ]; then
    openstack endpoint create --region "$region" "$service_type" "public" "$public_url"
fi

op_code=$?

#if [ $? -eq 0 ]; then
#    d_path=`realpath $state_file`
#    test -d "$d_path" || mkdir "$d_path"
#    touch "$state_file"
#fi

exit $op_code

