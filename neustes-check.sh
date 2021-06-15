#!/bin/bash

. ./settings.sh
IFS=$'\n'
timeout=3
check_file=${work_dir}/check_global.txt

check_newest() {
	client_name=$(echo $1 | awk -F ';' '{print $2}')
	client_gruppe=$(echo $1 | awk -F ';' '{print $3}')
	client_mac=$(echo $1 | awk -F ';' '{print $4}')
	client_ip=$(echo $1 | awk -F ';' '{print $5}')

	from_image=/var/linbo/${client_gruppe}.cloop.desc
	from_client=${work_dir}/check_${client_name}.txt

	client_offline=${from_client}.off
	echo -e "${BLUE}[Offline]${NC}" >${client_offline}
	ping -c${timeout} -W1 -i1 ${client_ip} && echo -e "${CYAN}[Pong]${NC}" >${client_offline} &
	sleep 2s
	curl -m $timeout http://${client_ip}:2718/image.desc 2>/dev/null > $from_client

	client_info="${client_gruppe}\t${client_ip}\t${client_mac}\t${client_name}"
	[ $(echo "${client_info}\t" | wc -c) -lt 50 ] && client_info+="\t"
	if ! [ -s $from_client ]; then
		echo -e "${client_info}\t$(cat ${client_offline})" >> $check_file
	elif diff -q $from_image $from_client >/dev/null; then
		echo -e "${client_info}\t${GREEN}(neuestes Image)${NC}" >> $check_file
	else
		for image_file in $(ls /var/linbo/${client_gruppe}*.cloop.desc); do
			if diff -q $image_file $from_client >/dev/null; then
				image_date=$(stat -c %y $image_file | cut -d '.' -f1)
				echo -e "${client_info}\t${RED}(${image_date})${NC}" >> $check_file
				break
			fi
		done
		if [ -z "$image_date" ]; then
			echo -e "${client_info}\t${RED}(älteres Image)${NC}" >> $check_file
		fi
	fi
}

for client in $(cat $work_input); do
	check_newest "$client" >/dev/null 2>&1 &
done

sleep 5s
sort -nk4 $check_file
