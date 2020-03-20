#!/bin/bash
#
# Deploy the redis service.
#

source "${GEN3_HOME}/gen3/lib/utils.sh"
gen3_load "gen3/gen3setup"

gen3 roll redis
g3kubectl apply -f "${GEN3_HOME}/kube/services/redis/redis-service.yaml"

gen3_log_info "The redis service has been deployed onto the kubernetes cluster"
