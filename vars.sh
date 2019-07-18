#!/usr/bin/env bash

ATTENDEES_COUNT=20
ATTENDEES_START=${ATTENDEES_START:-1}
ATTENDEES_END=${ATTENDEES_END:-20}


ORG=demo
SPACE_QUOTA=workshop-attendee

PASSWORD_PREFIX=password-

USER_PREFIX=user-
SPACE_PREFIX=space-


INSTRUCTOR_SPACE=demo
WORKSHOP_MD=$SCRIPT_ROOT/workshop.md
ENDPOINT=$(cf api | grep "api endpoint" | awk {'print $3'})

function attendee_password {
    echo ${PASSWORD_PREFIX}${1}
}
function do_for_attendees {
    operation=$1; shift;
    for i in $(seq $ATTENDEES_START $ATTENDEES_END)
    do 
        $operation $i $*
    done
}
