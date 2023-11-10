#!/usr/bin/env bash

# This is needed to locate the otelcol-contrib executable
export PATH="/opt/homebrew/bin:$PATH"

OTLP_HOSTNAME=$(defaults read com.vori.VoriPOS provisioned_otlpHostname)
OTLP_PORT=$(defaults read com.vori.VoriPOS provisioned_otlpPort)
OTLP_USERNAME=$(defaults read com.vori.VoriPOS provisioned_otlpUsername)
OTLP_PASSWORD=$(defaults read com.vori.VoriPOS provisioned_otlpPassword)
VORIPOS_ENVIRONMENT=$(defaults read com.vori.VoriPOS provisioned_environment)
VORIPOS_BANNER_ID=$(defaults read com.vori.VoriPOS provisioned_bannerID)
VORIPOS_BANNER_NAME=$(defaults read com.vori.VoriPOS provisioned_bannerName)
VORIPOS_STORE_ID=$(defaults read com.vori.VoriPOS provisioned_storeID)
VORIPOS_STORE_NAME=$(defaults read com.vori.VoriPOS provisioned_storeName)
VORIPOS_LANE_ID=$(defaults read com.vori.VoriPOS provisioned_laneID)
VORIPOS_LANE_NAME=$(defaults read com.vori.VoriPOS provisioned_laneName)

export OTLP_HOSTNAME
export OTLP_PORT
export OTLP_USERNAME
export OTLP_PASSWORD
export VORIPOS_ENVIRONMENT
export VORIPOS_BANNER_ID
export VORIPOS_BANNER_NAME
export VORIPOS_STORE_ID
export VORIPOS_STORE_NAME
export VORIPOS_LANE_ID
export VORIPOS_LANE_NAME
export VORIPOS_OTEL_COLLECTOR_VERSION=0.1.0

echo "Data will be exported to ${OTLP_HOSTNAME}:${OTLP_PORT}"
otelcol-contrib --config=file:$( dirname -- "$0"; )/config.yml
