#!/bin/bash

until vernemq ping
do
    sleep 1
done
sleep 3

create_user home-assistant ha
create_user node-red nr