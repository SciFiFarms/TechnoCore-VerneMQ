#!/bin/env bash

source ${TECHNOCORE_LIB}/create-secret.sh

# The secrets are in the format ${STACK_NAME}_${SERVICE_NAME}_${MOUNT_POINT}
# This takes $SERVICE_NAME and will generate usernames and passwords for any 
# credentials listed in the generated compose file that start with ${STACK_NAME}_${SERVICE_NAME} 
# and end in _username or _password. 
# The exception is if there is an admin username/password. In that case, ${STACK_NAME}_admin... does 
# not get created because there is no admin service.
#generate_password_for [your_service_name]
