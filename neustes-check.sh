#!/bin/bash

. "$(dirname $0)"/settings.sh
IFS=$'\n'
check_file=${work_dir}/check_global.txt

linbo_status() {
	ping -c3 -W1 -i0.5 ${client_ip} || return 0
	echo -e "${CYAN}[Pong]${NC}" >${client_offline}

	[ $(id -u) != 0 ] && return 0
	LINBO_SSH='linbo-ssh -o ConnectTimeout=1'

	ssh_ps_list=$(eval $LINBO_SSH ${client_ip} ps 2>/dev/null | grep -v grep)
	[ 0 -lt $(echo "${ssh_ps_list}" | wc -l) ] || return 0

	if [ 0 -lt $(echo "${ssh_ps_list}" | grep clone | wc -l) ]; then
		echo -e "${CYAN}[cloning]${NC}" >${client_offline}
	elif [ 0 -lt $(echo "${ssh_ps_list}" | grep cloop | wc -l) ]; then
		cloop_size=$(eval $LINBO_SSH ${client_ip} du -h /cache/${client_gruppe}.cloop 2>/dev/null | awk '{print $1}')
		echo -e "${CYAN}[${cloop_size}]${NC}" >${client_offline}
	else
		echo -e "${CYAN}[linbo]${NC}" >${client_offline}
	fi
}

check_newest() {
	client_name=$(echo $1 | awk -F ';' '{print $2}')
	client_gruppe=$(echo $1 | awk -F ';' '{print $3}')
	client_mac=$(echo $1 | awk -F ';' '{print $4}')
	client_ip=$(echo $1 | awk -F ';' '{print $5}')

	from_image=/srv/linbo/${client_gruppe}.cloop.info
	from_client=${work_dir}/check_${client_name}.txt

	client_offline=${from_client}.off
	echo -e "${BLUE}[Offline]${NC}" >${client_offline}
	linbo_status &
	curl -m 2 http://${client_ip}:2718/image.info 2>/dev/null > $from_client

	client_info="${client_gruppe}\t${client_ip}\t${client_mac}\t${client_name}"
	[ $(echo -e "${client_info}\t" | wc -c) -lt 53 ] && client_info+="\t"
	if ! [ -s $from_client ] && sleep 2s; then
		echo -e "${client_info}\t$(cat ${client_offline})" >> $check_file
	elif diff -q $from_image $from_client >/dev/null; then
		echo -e "${client_info}\t${GREEN}(neuestes Image)${NC}" >> $check_file
	else
		for image_file in $(ls /var/linbo/${client_gruppe}*.cloop.info); do
			if diff -q $image_file $from_client >/dev/null; then
				image_date=$(stat -c %y $image_file | cut -d '.' -f1)
				echo -e "${client_info}\t${RED}(${image_date})${NC}" >> $check_file
				break
			fi
		done
		if [ -z "$image_date" ]; then
			echo -e "${client_info}\t${RED}(unbekanntes Image)${NC}" >> $check_file
		fi
	fi
}

for client in $(cat $work_input); do
	check_newest "$client" >/dev/null 2>&1 &
done

sleep 5s
sort -n -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4 $check_file
cleanup
