#!/usr/bin/env bash
SCRIPT_ROOT=$(cd `dirname $0`; pwd)
source $SCRIPT_ROOT/vars.sh

function print_workshop_details {
    i=$1
    USER=${USER_PREFIX}${i}
    SPACE=${SPACE_PREFIX}${i}
    PASSWORD=`attendee_password $i`
    LOGIN_COMMAND="cf login -a $ENDPOINT -u $USER -p $PASSWORD -s $SPACE -o $ORG"
    echo "| $ENDPOINT | $ORG | $SPACE | $USER | $PASSWORD | \`$LOGIN_COMMAND\` |" >> $WORKSHOP_MD
}


cat <<EOF > $WORKSHOP_MD
# Attendee Workspace Details

|Endpoint|Org|Space|User|Password|Login Command|
|--------|---|-----|----|--------|-------------|
EOF
do_for_attendees print_workshop_details


