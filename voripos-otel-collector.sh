#!/usr/bin/env bash

# This is needed to locate the otelcol-contrib executable
export PATH="/opt/homebrew/bin:$PATH"

export VORIPOS_OTEL_COLLECTOR_VERSION=0.3.0
DEVICE_SERIAL_NUMBER=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

OIDC_CLIENT_ID=
OIDC_CLIENT_SECRET=
OIDC_TOKEN_URL=
OTLP_HOSTNAME=
OTLP_PORT=
VORIPOS_ENVIRONMENT=
VORIPOS_BANNER_ID=
VORIPOS_BANNER_NAME=
VORIPOS_STORE_ID=
VORIPOS_STORE_NAME=
VORIPOS_LANE_ID=
VORIPOS_LANE_NAME=

credentialsPath="$HOME/voripos/.credentials.json"
if test -f "$credentialsPath"; then
  echo "Reading from ${credentialsPath}..."
  content=$(cat "${credentialsPath}")
  OIDC_CLIENT_ID=$( jq -r  '.oidc.client_id | select( . != null )' <<< "${content}" )
  OIDC_CLIENT_SECRET=$( jq -r  '.oidc.client_secret | select( . != null )' <<< "${content}" )
  OIDC_TOKEN_URL=$( jq -r  '.oidc.token_url | select( . != null )' <<< "${content}" )
  OTLP_HOSTNAME=$( jq -r  '.otlp.hostname | select( . != null )' <<< "${content}" )
  OTLP_PORT=$( jq -r  '.otlp.port | select( . != null )' <<< "${content}" )
  VORIPOS_ENVIRONMENT=$( jq -r  '.metadata.environment | select( . != null )' <<< "${content}" )
  VORIPOS_BANNER_ID=$( jq -r  '.metadata.banner.id | select( . != null )' <<< "${content}" )
  VORIPOS_BANNER_NAME=$( jq -r  '.metadata.banner.name | select( . != null )' <<< "${content}" )
  VORIPOS_STORE_ID=$( jq -r  '.metadata.store.id | select( . != null )' <<< "${content}" )
  VORIPOS_STORE_NAME=$( jq -r  '.metadata.store.name | select( . != null )' <<< "${content}" )
  VORIPOS_LANE_ID=$( jq -r  '.metadata.lane.id | select( . != null )' <<< "${content}" )
  VORIPOS_LANE_NAME=$( jq -r  '.metadata.lane.name | select( . != null )' <<< "${content}" )
else
  echo "Reading from UserDefaults..."
  OIDC_CLIENT_ID=$(defaults read com.vori.VoriPOS provisioned_oidcClientID)
  OIDC_CLIENT_SECRET=$(defaults read com.vori.VoriPOS provisioned_oidcClientSecret)
  OIDC_TOKEN_URL=$(defaults read com.vori.VoriPOS provisioned_oidcTokenUrl)
  OTLP_HOSTNAME=$(defaults read com.vori.VoriPOS provisioned_otlpHostname)
  OTLP_PORT=$(defaults read com.vori.VoriPOS provisioned_otlpPort)
  VORIPOS_ENVIRONMENT=$(defaults read com.vori.VoriPOS provisioned_environment)
  VORIPOS_BANNER_ID=$(defaults read com.vori.VoriPOS provisioned_bannerID)
  VORIPOS_BANNER_NAME=$(defaults read com.vori.VoriPOS provisioned_bannerName)
  VORIPOS_STORE_ID=$(defaults read com.vori.VoriPOS provisioned_storeID)
  VORIPOS_STORE_NAME=$(defaults read com.vori.VoriPOS provisioned_storeName)
  VORIPOS_LANE_ID=$(defaults read com.vori.VoriPOS provisioned_laneID)
  VORIPOS_LANE_NAME=$(defaults read com.vori.VoriPOS provisioned_laneName)
fi

export DEVICE_SERIAL_NUMBER
export OIDC_CLIENT_ID
export OIDC_CLIENT_SECRET
export OIDC_TOKEN_URL
export OTLP_HOSTNAME
export OTLP_PORT
export VORIPOS_ENVIRONMENT
export VORIPOS_BANNER_ID
export VORIPOS_BANNER_NAME
export VORIPOS_STORE_ID
export VORIPOS_STORE_NAME
export VORIPOS_LANE_ID
export VORIPOS_LANE_NAME

echo "Data will be exported to ${OTLP_HOSTNAME}:${OTLP_PORT}"
otelcol-contrib --config="file:$( dirname -- "$0"; )/config.yml"
