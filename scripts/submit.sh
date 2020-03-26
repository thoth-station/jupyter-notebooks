#!/bin/bash

set -x

set -eo pipefail


STANDARD_IMAGES=$(cat "config/standard-images.json")

main() {
	USE_DOCKER=${USE_DOCKER:-0}
	if [ $USE_DOCKER != 0]; then
		docker run \
			-v "$(pwd)/workflows":/tmp:ro  \
			argoproj/argocli:v2.4.3 submit \
			--parameter standard-images="$STANDARD_IMAGES" \
			--insecure-skip-tls-verify					   \
			--wait $@ /tmp/notebook-builder-workflow.yaml
	else
			argo submit \
			--parameter standard-images="$STANDARD_IMAGES" \
			--wait $@ $(pwd)/workflows/notebook-builder-workflow.yaml
	fi
}

main $@
