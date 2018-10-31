#!/usr/bin/env bash

function create()
{
    mosquitto_pub -i mqtt_add_user -h mqtt -p 8883 -q 1 \
        -t mqtt/add/user/testuser \
        -m "password" \
        -u $(cat /run/secrets/mqtt_username) \
        -P "$(cat /run/secrets/mqtt_password)" \
        -d \
        --cafile /run/secrets/ca 
}
create
