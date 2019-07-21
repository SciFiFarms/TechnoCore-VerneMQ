#!/bin/env bash

# Defaults to the service's directory name. 
service_name=${PWD##*/}

# Leave blank to disable this service by default.
set_service_flag $service_name
#set_service_flag $service_name yes

# Sets the application prefix depending on what $INGRESS_TYPE is set to. 
# Results in one of the following paths: 
# https://some.domain/prefix/
# https://prefix.some.domain/
path_prefix ${service_name^^} $service_name

# This is how to optionally include additional .yml files. See the prometheus repo 
# for a complete example.
## If the include exporters flag is set
#if [ ! -z "$SERVICE_prometheus_exporters" ]; then
#    export SERVICE_CONFIG_prometheus_exporters=${TECHNOCORE_SERVICES}/prometheus/exporters.yml
#fi

