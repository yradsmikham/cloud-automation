#!/bin/bash
#
# Maintenance restart for the Selenium Hub & Nodes.
#
# vpc_name="qaplanetv1"
# 52   1   *   *   *    (if [ -f $HOME/cloud-automation/files/scripts/qa-restart-selenium.sh ]; then bash $HOME/cloud-automation/files/scripts/qa-restart-selenium.sh; else echo "no qa-restart-selenium.sh"; fi) > $HOME/qa-restart-selenium.log 2>&1

export GEN3_HOME="$HOME/cloud-automation"
export vpc_name="${vpc_name:-"qaplanetv1"}"
export KUBECONFIG="${KUBECONFIG:-"$HOME/${vpc_name}/kubeconfig"}"

if [[ ! -f "$KUBECONFIG" ]]; then
  KUBECONFIG="$HOME/Gen3Secrets/kubeconfig"
fi

if ! [[ -d "$HOME/cloud-automation" && -d "$HOME/cdis-manifest" && -f "$KUBECONFIG" ]]; then
  echo "ERROR: this does not look like a QA environment"
  exit 1
fi

PATH="${PATH}:/usr/local/bin"

if [[ -z "$USER" ]]; then
  export USER="$(basename "$HOME")"
fi

source "${GEN3_HOME}/gen3/gen3setup.sh"

if ! [[ -d "$HOME/gen3-qa" ]]; then
  git clone https://github.com/uc-cdis/gen3-qa.git
fi
cd gen3-qa
git pull
# TODO: Remove this once the test is merged to master
git checkout task/ci_tests_for_bucket_manifest_generation
npm install
http_proxy=http://cloud-proxy.internal.io:3128
https_proxy=http://cloud-proxy.internal.io:3128
no_proxy=localhost,127.0.0.1,localaddress,169.254.169.254,.internal.io,logs.us-east-1.amazonaws.com
export JENKINS_HOME="test"
mkdir testData
export TEST_DATA_PATH="$PWD/testData"
export GOOGLE_APP_CREDS_JSON="$(cat $HOME/qaplanetv2/apis_configs/fence_google_app_creds_secret.json)"
g3kubectl port-forward $(g3kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep selenium-hub) 4444:4444 &
sed -i 's/host: '\''selenium-hub'\'',/host: '\''localhost'\'',/' codecept.conf.js
export HOSTNAME="https://qa.planx-pla.net/"
GEN3_SKIP_PROJ_SETUP=true NAMESPACE="default" npm test -- --reporter mocha-multi suites/batch/bucketManifestGenerationTest.js
RC=$?
if [ $RC != 0 ]; then
  echo "The test did not pass!"
  curl -X POST --data-urlencode "payload={\"channel\": \"#test-bots\", \"username\": \"bucket-manifest-ci\", \"text\": \"The Bucket Manifest CI test failed :red_circle: -- Please check the \`cloud-automation\` repo for any regressions.\", \"icon_emoji\": \":bucket:\"}" $(g3kubectl get configmap global -o jsonpath={.data.ci_test_notifications_webhook})
else
  echo "The test was successful!"
  curl -X POST --data-urlencode "payload="channel\": \"#test-bots\", \"username\": \"bucket-manifest-ci\", \"text\": \"The Bucket Manifest CI test passed :white_check_mark:\", \"icon_emoji\": \":bucket:\"}" $(g3kubectl get configmap global -o jsonpath={.data.ci_test_notifications_webhook})
fi
