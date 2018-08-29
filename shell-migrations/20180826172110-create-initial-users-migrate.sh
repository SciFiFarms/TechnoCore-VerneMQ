#!/bin/bash

add_user_to_vernemq $(cat /run/secrets/portainer_mqtt_username) $(cat /run/secrets/portainer_mqtt_password)
add_user_to_vernemq $(cat /run/secrets/mqtt_username) $(cat /run/secrets/mqtt_password)

# Make sure the new users are usable for later migrations.
force_reboot=1
export force_reboot