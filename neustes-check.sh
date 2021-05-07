#!/bin/bash

. ./settings.sh
IFS=$'\n'
timeout=3
check_file=${work_dir}/check_global.txt

check_newest() {
	client_name=$(echo $1 | awk -F ';' '{print $2}')
	client_gruppe=$(echo $1 | awk -F ';' '{print $3}')
	client_ip=$(echo $1 | awk -F ';' '{print $5}')

	from_image=/var/linbo/${client_gruppe}.cloop.desc
	from_client=${work_dir}/check_${client_name}.txt

	curl -m $timeout http://${client_ip}:2718/image.desc 2>/dev/null > $from_client
	if ! [ -s $from_client ]; then
		echo -e "${client_gruppe}\t${client_ip}\t${client_name}\t${BLUE}[Offline]${NC}" >> $check_file
	elif diff -q $from_image $from_client >/dev/null; then
		echo -e "${client_gruppe}\t${client_ip}\t${client_name}\t${GREEN}(neuestes Image)${NC}" >> $check_file
	else
		echo -e "${client_gruppe}\t${client_ip}\t${client_name}\t${RED}(älteres Image)${NC}" >> $check_file
	fi
}

for client in $(cat $work_input); do
	check_newest "$client" &
done

sleep ${timeout}.9s
sort -nk2 $check_file
