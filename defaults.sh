#!/bin/env bash

#TODO: Anything that gets sent to STDOUT from this file gets included in the 
#      final compose file, which usually breaks it. 

# compose.sh defaults $service_name to the service's directory name. It can be overridden here. 
# service_name=

# Leave blank to disable this service by default.
set_service_flag $service_name
#set_service_flag $service_name yes

# Sets the application prefix depending on what $INGRESS_TYPE is set to. 
# Results in one of the following paths: 
# https://some.domain/prefix/
# https://prefix.some.domain/
# prefix=$service_name

# This is how to optionally include additional .yml files. See the prometheus repo 
# for a complete example.
## If the include exporters flag is set
#if [ ! -z "$SERVICE_prometheus_exporters" ]; then
#    export SERVICE_CONFIG_prometheus_exporters=${TECHNOCORE_SERVICES}/prometheus/exporters.yml
#fi

#generate_mount dev shell-migrations /usr/share/dogfish/shell-migrations
