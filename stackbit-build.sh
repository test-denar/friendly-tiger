#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://dev-api.stackbit.com/project/5de643f2600c9a0012faabee/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://dev-api.stackbit.com/pull/5de643f2600c9a0012faabee 
fi
curl -s -X POST https://dev-api.stackbit.com/project/5de643f2600c9a0012faabee/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://dev-api.stackbit.com/project/5de643f2600c9a0012faabee/webhook/build/publish > /dev/null
