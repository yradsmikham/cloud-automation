#!/bin/bash
#
# TBD
#

set -e

source "${GEN3_HOME}/gen3/lib/utils.sh"
gen3_load "gen3/gen3setup"


if [[ -z "$GEN3_NOPROXY" ]]; then
  export http_proxy=${http_proxy:-'http://cloud-proxy.internal.io:3128'}
  export https_proxy=${https_proxy:-'http://cloud-proxy.internal.io:3128'}
  export no_proxy=${no_proxy:-'localhost,127.0.0.1,169.254.169.254,.internal.io,logs.us-east-1.amazonaws.com,kibana.planx-pla.net'}
fi

namespace="$1"
if ! shift || [[ -z "$namespace" || (! "$namespace" =~ ^[a-z][a-z0-9-]*$) || "$namespace" == "$vpc_name" ]]; then
  gen3_log_err "Use: bash commision-env.sh namespace templateEnv, namespace is alphanumeric"
  exit 1
fi
templateEnv="$2"
if [[ -z "$templateEnv" || (! "$templateEnv" =~ ^[a-z][a-z0-9-]*$) || "$templateEnv" == "$vpc_name" ]]; then
  gen3_log_err "Use: bash commision-env.sh namespace templateEnv, templateEnv is alphanumeric"
  exit 1
fi

gen3_log_info "About to invoke kube-dev-namespace $namespace"
gen3_log_info "Cntrl-C in next 5 seconds to bail out"
sleep 5


gen3 kube-dev-namespace $namespace
RC=$?
if [ $RC -ne 0 ]; then
  echo "oh nous"
  exit 1
fi

gen3_log_info "copying artifacts from $templateEnv into $namespace"
if [[ -d "/home/$(whoami)/cdis-manifest/$templateEnv" ]]; then
  mkdir /home/$namespace/cdis-manifest/$namespace
  cp -r "/home/$(whoami)/cdis-manifest/$templateEnv" "/home/$namespace/cdis-manifest/$namespace"
  echo "the artifacts of our ephemeral env have been copied."
fi

echo "TODO: now switch to the new namespace and run gen3 roll all"
export KUBECTL_NAMESPACE="$namespace"
# gen3 roll all
