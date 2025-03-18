#!/usr/bin/bash

WANDA_URL=${WANDA_URL:-http://localhost:4000}
FACTS_SERVICE_URL=${FACTS_SERVICE_URL:-amqp://wanda:wanda@localhost:5672}
DEBUG=${DEBUG:-false}

function log_file {
	echo "/tmp/checks.$(date +%Y%m%d).log"
}

function debug {
	if [ "$DEBUG" == "true" ]; then
		for e in "$@"; do
			echo "[$(date '+%Y-%m-%d %H:%M:%S')] DEBUG: $e" >>"$(log_file)"
		done
	fi
}

function start_agent() {
	agent_id=${1:?argument required}
	dockerfile_path=${2:?argument required}
	fixture_path=${3:?argument required}
	image_name="trento_bbq_agent:$(echo -n "$fixture_path" | sha256sum | awk '{print $1}')"
	container_name="trento_bbq_agent_$(uuidgen)"

	(

		debug "building image $image_name from $fixture_path"

		docker build -f "$dockerfile_path" -t "$image_name" "$fixture_path"

		debug "running container $container_name for agent $agent_id"

		docker run -d --rm --name "$container_name" \
			--env FACTS_SERVICE_URL="$FACTS_SERVICE_URL" \
			--env AGENT_ID="$agent_id" \
			--network host \
			"$image_name"

	) >/dev/null

	echo "$container_name"
}

function stop_agent() {
	container_name=${1:?argument required}
	docker kill "$container_name"
}

function start_check_execution() {
	agent_id=${1:?argument required}
	check_ids=\"${2:?argument required}\"
	shift 2
	for check_id in "$@"; do
		check_ids="$check_ids,\"$check_id\""
	done

	execution_id=$(uuidgen)
	data=$(
		cat <<EOF
{
    "target_type": "cluster",
    "env": {
        "provider": "azure"
    },
    "execution_id": "$execution_id",
    "group_id": "3dff9d03-4adf-453e-9513-8533e221bb12",
    "targets": [
        {
            "agent_id": "$agent_id",
            "checks": [$check_ids]
        }
    ]
}
EOF
	)

	debug "starting check execution $execution_id for agent $agent_id with checks $check_ids"
	debug "$data"

	code=$(curl -s -o /dev/null \
		-w "%{http_code}" \
		--request POST "$WANDA_URL/api/v1/checks/executions/start" \
		--header 'accept: application/json' \
		--header 'Content-Type: application/json' \
		--data-raw "$data")

	debug "response code: $code"

	[ "$code" -eq 202 ] || exit 1

	echo "$execution_id"
}

function get_check_execution() {
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

function assert_check_result() {
	expected=${1:?argument required}
	check_info=${2:?argument required}

	debug "asserting check is $expected"
	debug "$check_info"

	status=$(echo "$check_info" | jq -r '.status')
	result=$(echo "$check_info" | jq -r '.result')
	[ "$status" = "completed" ] && [ "$result" = "$expected" ] || exit 1
}
