#!/bin/bash

# $1: The username to create.
# $2: The password to use.
add_user_to_vernemq()
{
    # Need to make sure the create flag gets passed if the passwd file doesn't exist.
    create=""
    if [ ! -f /etc/vernemq/vmq.passwd ]
    then
        create="-c"

    fi
    expect - <<EOF
set timeout -1
spawn vmq-passwd $create /etc/vernemq/vmq.passwd $1
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
    #echo "user $1\rtopic \r" >> /etc/vernemq/vmq.acl

}

# $1: The username to create
# $2: The service this user is for
function create_user()
{
    # TODO: I think there is a programatic way to do this that would allow for 
    # max retries annd sleep time to be passed in as parameters. 
    until local response=$(curl --cacert /run/secrets/ca \
        -H "X-Vault-Token: $(cat /run/secrets/token)" \
        -X POST \
        https://vault:8200/v1/sys/tools/random/32);
    do
        echo "Can't reach Vault, sleeping."
        sleep 5
    done;
    mqtt_password=$(extract_from_json random_bytes "$response")

    add_user_to_vernemq $1 $mqtt_password
    create_secret $2_mqtt_username $1
    create_secret $2_mqtt_password $mqtt_password
}