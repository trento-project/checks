#!/usr/bin/env sh

# Base URL for the Wanda API
WANDA_URL=${WANDA_URL:-http://localhost:4000}
# AMQP URL for the Facts service (RabbitMQ)
FACTS_SERVICE_URL=${FACTS_SERVICE_URL:-amqp://wanda:wanda@localhost:5672}
# DEBUG=true will log debug messages to /tmp/checks.YYYYMMDD.log
DEBUG=${DEBUG:-false}
# OCI_REGISTRY is used to pull the agent image from a private registry
# set it to "localhost/" when using Podman locally
OCI_REGISTRY=${OCI_REGISTRY:-""}
# log file for debug messages
log_file="/tmp/checks.$(date +%Y%m%d).log"

debug() {
	if [ "$DEBUG" = "true" ]; then
		for e in "$@"; do
			echo "[$(date '+%Y-%m-%d %H:%M:%S')] DEBUG: $e" >>"$log_file"
		done
	fi
}

start_agent() {
	agent_id=${1:?argument required}
	dockerfile_path=${2:?argument required}
	fixture_path=${3:?argument required}
	image_name="trento_bbq_agent:$(echo "$fixture_path" | sha256sum | awk '{print $1}')"
	container_name="trento_bbq_agent_$(uuidgen)"

	(

		debug "building image $image_name from $fixture_path"

		docker build -f "$dockerfile_path" -t "$image_name" "$fixture_path"

		debug "running container $container_name for agent $agent_id"

		docker run -d --rm --name "$container_name" \
			--env FACTS_SERVICE_URL="$FACTS_SERVICE_URL" \
			--env AGENT_ID="$agent_id" \
			--network host \
			"$OCI_REGISTRY$image_name"

	) >/dev/null

	echo "$container_name"
}

stop_agent() {
	container_name=${1:?argument required}
	docker kill "$container_name"
}

start_check_execution() {
	request=${1:?argument required}

	debug "starting check execution"
	debug "$request"

	code=$(curl -s -o /dev/null \
		-w "%{http_code}" \
		--request POST "$WANDA_URL/api/v1/checks/executions/start" \
		--header 'accept: application/json' \
		--header 'Content-Type: application/json' \
		--data-raw "$request")

	debug "response code: $code"

	[ "$code" -eq 202 ] || exit 1

	echo "$execution_id"
}

get_check_execution() {
	execution_id=${1:?argument required}

	debug "getting check execution $execution_id"

	attempt=1
	while [ $attempt -lt 4 ]; do
		debug "attempt: $attempt"
		check_info=$(curl -s \
			--request GET "$WANDA_URL/api/v1/checks/executions/$execution_id" \
			--header 'accept: application/json' \
			--header 'Content-Type: application/json')

		debug "$check_info"

		check_status=$(echo "$check_info" | jq -r '.status')
		if [ "$check_status" = "running" ]; then
			debug "check execution $execution_id still running, waiting 3s"
			sleep 3s
			attempt=$((attempt + 1))
			continue
		else
			debug "check execution $execution_id completed"
			echo "$check_info"
			return
		fi
	done
}

assert_check_result() {
	expected=${1:?argument required}
	check_info=${2:?argument required}

	debug "asserting check is $expected"
	debug "$check_info"

	status=$(echo "$check_info" | jq -r '.status')
	result=$(echo "$check_info" | jq -r '.result')
	[ "$status" = "completed" ] && [ "$result" = "$expected" ] || exit 1
}
