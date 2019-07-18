#!/usr/bin/env bash
SCRIPT_ROOT=$(cd `dirname $0`; pwd)
source $SCRIPT_ROOT/vars.sh


# Create quota
cf create-space-quota $SPACE_QUOTA -a 4 -i 2gb -m 5G -r 5 -s 2

# Create users

function prepare_env {
    i=$1
    USER=${USER_PREFIX}${i}
    SPACE=${SPACE_PREFIX}${i}
    PASSWORD=`attendee_password $i`
    SPACE_ROLE=SpaceDeveloper
    cf create-user $USER $PASSWORD 
    cf create-space $SPACE -q $SPACE_QUOTA
    cf set-space-role $USER $ORG $SPACE $SPACE_ROLE 
}

do_for_attendees prepare_env

