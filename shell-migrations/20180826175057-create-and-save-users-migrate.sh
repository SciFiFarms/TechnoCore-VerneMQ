#!/bin/bash

until vernemq ping
do
    #echo "Couldn't reach MQTT. Sleeping."
    sleep 1
done
sleep 3

create_user home-assistant "home_assistant&ha"
create_user node-red "node_red&nr"