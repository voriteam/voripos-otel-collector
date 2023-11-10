# VoriPOS OpenTelemetry Collector

This repository contains an OpenTelemetry Collector configured for VoriPOS.

## Installation
This service is distributed via Homebrew.

```shell
brew tap voriteam/voripos
brew install voripos-otel-collector
brew services start voripos-otel-collector
```

## Distribution
1. Update `VORIPOS_OTEL_COLLECTOR_VERSION`.
2. Create a release on GitHub.
3. Follow the instructions at https://github.com/voriteam/homebrew-voripos to update the tap with the latest version.
