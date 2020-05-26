#!/bin/bash
#
# Install this as a cron job under /etc/cron.d/ :
#
#
# GEN3_HOME=/home/ubuntu/cloud-automation
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#
# 1 1 * * 0 root (date && bash $GEN3_HOME/gen3/bin/gen3-authz.sh apply adminvm) > /var/log/gen3AuthzCron.log 2>&1
#

export GEN3_HOME="${GEN3_HOME:-$HOME/cloud-automation}"

if [[ ! -f "$GEN3_HOME/gen3/gen3setup.sh" ]]; then
  echo "ERROR: invalid GEN3_HOME: $GEN3_HOME"
  exit 1
fi

source "$GEN3_HOME/gen3setup.sh"

gen3_log_info "no customization required by the adminvm setup"