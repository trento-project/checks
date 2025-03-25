#!/usr/bin/env bats

setup() {
	# Set the test root as the project root
	DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
	FIXTURES="$DIR/fixtures"
	# shellcheck source=/dev/null
	source "$DIR/utils.sh"
	# the current check id is the filename without extension
	check_id=$(basename "$BATS_TEST_FILENAME" | cut -d. -f1)
}

@test "it should pass on a correct Corosync timeout configuration" {

	agent_id=$(uuidgen)
	agent_container=$(
		start_agent "$agent_id" \
			"$FIXTURES/Dockerfile.agent" \
			"$FIXTURES/standard"
	)

	sleep 1s

	execution_id="$(uuidgen)"
	request=$(
		cat <<EOF
{
    "target_type": "cluster",
    "env": {
        "provider": "azure"
    },
    "execution_id": "$execution_id",
    "group_id": "$(uuidgen)",
    "targets": [
        {
            "agent_id": "$agent_id",
            "checks": ["$check_id"]
        }
    ]
}
EOF
	)

	run start_check_execution "$request"
	[ "$status" -eq 0 ]

	sleep 1s

	run get_check_execution "$execution_id"
	[ "$status" -eq 0 ]
	check_info="$output"

	run assert_check_result "passing" "$check_info"
	[ "$status" -eq 0 ]

	stop_agent "$agent_container"

}

@test "it should fail on a broken Corosync timeout configuration" {

	agent_id=$(uuidgen)
	agent_container=$(
		start_agent "$agent_id" \
			"$FIXTURES/Dockerfile.agent" \
			"$FIXTURES/broken_corosync_conf"
	)

	sleep 1s

	execution_id="$(uuidgen)"
	request=$(
		cat <<EOF
{
    "target_type": "cluster",
    "env": {
        "provider": "azure"
    },
    "execution_id": "$execution_id",
    "group_id": "$(uuidgen)",
    "targets": [
        {
            "agent_id": "$agent_id",
            "checks": ["$check_id"]
        }
    ]
}
EOF
	)

	run start_check_execution "$request"
	[ "$status" -eq 0 ]

	sleep 1s

	run get_check_execution "$execution_id"
	[ "$status" -eq 0 ]
	check_info="$output"

	run assert_check_result "critical" "$check_info"
	[ "$status" -eq 0 ]

	stop_agent "$agent_container"

}
