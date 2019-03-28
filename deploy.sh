#!/bin/bash -e
#Usage deploy.sh properties_file tag_number
. $1

TAG=$2
# register task-definition
sed <td-devops.template -e "s|@VERSION@|$VERSION|;s|@IMAGE@|$IMAGE|;s|@PORT@|$PORT|;s|@NAME@|$NAME|;s|@TAG@|$TAG|">TASKDEF.json
aws ecs register-task-definition --cli-input-json file://TASKDEF.json > REGISTERED_TASKDEF.json
TASKDEFINITION_ARN=$( < REGISTERED_TASKDEF.json jq .taskDefinition.taskDefinitionArn )

# create or update service
sed "s|@@TASKDEFINITION_ARN@@|$TASKDEFINITION_ARN|;s|@NAME@|$NAME|" <service-update-devops.json >SERVICEDEF.json
aws ecs update-service --cli-input-json file://SERVICEDEF.json | tee SERVICE.json
