#!/bin/bash

# $1: The username to create.
# $2: The password to use.
add_user_to_vernemq()
{
    # Need to make sure the create flag gets passed if the passwd file doesn't exist.
    create=""
    if [ ! -f /vernemq/etc/vmq.passwd ]
    then
        create="-c"

    fi
    expect - <<EOF
set timeout -1
spawn vmq-passwd $create /vernemq/etc/vmq.passwd $1
match_max 100000
expect -exact "Password: "
send -- "$2\r"
expect -exact "\r
Reenter password: "
send -- "$2\r"
expect eof
EOF
    echo "Done with expect"
    # TODO: Add user permissions to user creation?
    echo "user $1\rtopic \r" >> /vernemq/etc/vmq.acl

}