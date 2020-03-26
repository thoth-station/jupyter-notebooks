#!/bin/bash

set -x

set -eo pipefail

STANDARD_IMAGES=$(cat "config/standard-images.json")


main() {
	: "${1?Positional argument namespace was not provided}"
	: "${2?Positional argument apiserver was not provided}"
	: "${TOKEN?Muset set TOKEN env var}"

	local namespace="$1"
	local apiserver="$2"

	docker run \
		-v "$(pwd)/workflows":/tmp:ro  \
		argoproj/argocli:v2.4.3 submit \
		--token "$TOKEN"                               \
		--server    "$apiserver"                       \
		--namespace "$namespace"                       \
		--parameter standard-images="$STANDARD_IMAGES" \
		--insecure-skip-tls-verify					   \
		--wait /tmp/notebook-builder-workflow.yaml
}

main $@
