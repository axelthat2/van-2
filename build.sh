#!/bin/bash

yarn global add @sentry/cli

yarn build:static

release="--auth-token ${SENTRY_AUTH_TOKEN} releases --org cashforcarsio --project javascript"

sentry-cli $release files vance-dance delete --all

sentry-cli $release new vance-dance --finalize

sentry-cli $release files vance-dance upload-sourcemaps ./dist/_nuxt/*.map ./dist/_nuxt/*.js --url-prefix "~/_nuxt"

for path in ./dist/_nuxt/*.js; do
  sed -i '$ d' "$path"
done

rm -rf ./dist/_nuxt/*.map

