#!/bin/bash

BASE_URL="https://damp-wave-32692.herokuapp.com"

is_internet_connected () {
  interface=$(ifconfig enp4s0 | grep inet)
  if [[ $interface == "" ]]; then
    echo 0
  else
    echo 1
  fi
}

current_month_output () {
  while [ "$(is_internet_connected)" == "0" ]; do sleep 5; done
  curl -s "$BASE_URL/savings/totals/month" | jq -r '.total'
}

create_new_saving () {
	value="$1"

  while [ "$(is_internet_connected)" == "0" ]; do sleep 5; done
	curl --write-out '%{http_code}' -s -o /dev/null -X POST "$BASE_URL/savings" -H "Content-Type: application/json" -d "{\"value\": $value}"
}

new_saving () {
	request_status=$(create_new_saving "$1")
	if [[ $request_status == "201" ]]; then
		echo "Saving created successfully."
	else
		echo "Error creating saving."
	fi
}

format_output () {
	value="$1"
	printf "R$ %1.2f" "$value"
}

current_month () {
	value=$(current_month_output)
	format_output "$value"
}

main () {
	opt="$1"

	if [[ $opt == "-i" ]]; then
		value="$2"
		new_saving "$value"
	elif [[ $opt == "-s" ]]; then
		current_month
  else
    current_month
	fi
}

main "$@"
