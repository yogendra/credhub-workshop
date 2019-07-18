#!/usr/bin/env bash
SCRIPT_ROOT=$(cd `dirname $0`; pwd)
source $SCRIPT_ROOT/vars.sh



#### Cleanup instructor space
#unbind services
cf target -s $INSTRUCTOR_SPACE

cf delete spring-music -f -r

cf delete twitter-stream -f -r

cf delete-service -f twitter

cf delete-service -f db

#list apps and services

cf apps

cf services


function cleaup_attendee {
    i=$1
    USER=${USER_PREFIX}${i}
    SPACE=${SPACE_PREFIX}${i}
    cf delete-user -f $USER
    cf delete-space $SPACE -o $ORG -f
}


do_for_attendees cleaup_attendee
