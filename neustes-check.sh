#!/bin/bash

. ./settings.sh
IFS=$'\n'
timeout=3
check_file="$(dirname $0)/$(basename $0 .sh).txt"

check_newest() {
	client_name=$(echo $1 | awk -F ';' '{print $2}')
	client_gruppe=$(echo $1 | awk -F ';' '{print $3}')
	client_ip=$(echo $1 | awk -F ';' '{print $5}')

	from_image=/var/linbo/${client_gruppe}.cloop.desc
	from_client=${work_dir}/check_${client_name}.txt

	curl -m $timeout http://${client_ip}:2718/image.desc 2>/dev/null > $from_client
	if diff -q $from_image $from_client >/dev/null; then
		echo -e "${client_gruppe}\t${client_ip}\t${client_name}" >> $check_file
	elif ! grep -q $client_name $check_file; then
		echo -e "${client_gruppe}\t${client_ip}\t${client_name}"
	fi
}

for client in $(cat $work_input); do
	check_newest "$client" &
	sleep 0.1s
done

sleep ${timeout}.3s
sort -u $check_file > ${check_file}.tmp
mv ${check_file}.tmp $check_file
