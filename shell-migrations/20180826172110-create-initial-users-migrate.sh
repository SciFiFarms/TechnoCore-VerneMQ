#!/bin/bash

add_user_to_vernemq ${ADMIN_USER} $(cat /run/secrets/admin_password)

for user in /run/secrets/users/*; do
    add_user_to_vernemq "$(basename $user)" "$(cat $user)"
done

# Make sure the new users are usable for later migrations.
force_reboot=1
export force_reboot