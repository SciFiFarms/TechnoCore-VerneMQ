#!/bin/bash

reboot_function()
{
    until vernemq ping
    do
        sleep 1
    done
    
    sleep 2 && vernemq stop &
}

# $1: The field to extract. 
# $2: The JSON string.
extract_from_json(){
    grep -Eo '"'$1'":.*?[^\\]"' <<< "$2" | cut -d \" -f 4
}

# $1: The mount point(Without stack reference, this will be delt with on portainer's end.)
#   Should be of the format service_name/mount_point
#   If the swarm service is different than the service name used to save the 
#   secret, then use secret_service_name&swarm_service_name. For example:
#   portainer/secret/create/node-red&nr/mqtt_username
# $2: The secret itself
function create_secret()
{
    mosquitto_pub -i create_secret_client -h mqtt -p 8883 -q 1 \
        -r \
        -t portainer/secret/create/$1 \
        -m "$2" \
        -u $(cat /run/secrets/mqtt_username) \
        -P "$(cat /run/secrets/mqtt_password)" \
        --cafile /run/secrets/ca 
}