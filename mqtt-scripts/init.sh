#!/usr/bin/env bash

function import_lib()
{

for file in /usr/share/dogfish/shell-migrations-shared/*.sh; do
    # TODO: Make this ignore .pub files? Or maybe I just use *.sub.
    #if [ "$file" == "/usr/share/mqtt-scripts/init.sh" ] ; then
    #    continue;
    #fi
    source $file &
done

for file in /usr/share/dogfish/shell-migrations/shared/*.sh; do
    # TODO: Make this ignore .pub files? Or maybe I just use *.sub.
    #if [ "$file" == "/usr/share/mqtt-scripts/init.sh" ] ; then
    #    continue;
    #fi
    source $file &
done

# START HERE. It appears that the function add_mqtt_user_to_vern (or something like that) from one of the above is not getting sourced, or the context is wrong. 
# Maybe try wrapping in a function? Or implement a import in the .sub file. 
for file in /usr/share/mqtt-scripts/*.sub; do
    # TODO: Make this ignore .pub files? Or maybe I just use *.sub.
    if [ "$file" == "/usr/share/mqtt-scripts/init.sh" ] ; then
        continue;
    fi
    source $file &
done

}

import_lib