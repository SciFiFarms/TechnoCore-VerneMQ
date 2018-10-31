#!/bin/bash

#echo "Running middle migration."

# TODO: Find a better way to check that the server is up and remove the sleep. 
# The issue is that vernemq ping works as soon as the server starts to load, long before 
# the server is actually ready to ready to handle these requests. However, I 
# haven't found a good replacement as at this stage, the credentials needed to
# log in haven't been set up yet. Moving to key based authentication could solve this. 
until vernemq ping
do
    echo "Couldn't reach MQTT. Sleeping."
    sleep 1
done
sleep 5
#echo "Finished wait for middle migration."

add_user_to_vernemq $(cat /run/secrets/portainer_mqtt_username) $(cat /run/secrets/portainer_mqtt_password)
add_user_to_vernemq $(cat /run/secrets/mqtt_username) $(cat /run/secrets/mqtt_password)

# Make sure the new users are usable for later migrations.
force_reboot=1
export force_reboot