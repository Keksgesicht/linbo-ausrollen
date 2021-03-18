#!/bin/bash

work_pc="/etc/linuxmuster/workstations"
work_dir="/tmp/ausrollen"

work_all="$work_dir/all.txt"
work_input="$work_dir/groups.txt"
work_output="$work_dir/roll.txt"

linbo_exec="/usr/sbin/linbo-remote"
linbo_params_sync="-w 1000 -b 0 -p format,sync:1,start:1"
linbo_params_start=$(echo -e "-w 60 -b 0 start:1\n-c start:1")

case $1 in
	'-start')
		linbo_params=$linbo_params_start
		shift
	;;
	'-sync')
		linbo_params=$linbo_params_sync
		shift
	;;
	*)
		linbo_params=$linbo_params_sync
	;;
esac

groups="win10fs2 win10smart"
room_pc="306 611 612"

interval="300s"
part_size="20"

next_round_prompt() {
	while true; do
		read -p "nächste Runde? " ans
		if [ "$ans" == "ja" ]; then
			break
		fi
	done
}

roll_out() {
	. ./ausrollen.sh
	if [ -z "$interval" ] || [ "$interval" == "0" ]; then
		next_round_prompt
	else
		sleep $interval
	fi
}

mkdir $work_dir 2>/dev/null
rm $work_dir/*.txt 2>/dev/null
cat $work_pc | sort -t';' -nk2 > $work_all

truncate -s 0 $work_input
for g in $groups; do
	grep $g $work_all > $work_dir/$g.txt
	cat ${work_dir}/${g}.txt >> $work_input
done
sort -t';' -nk2 $work_input > ${work_input}.tmp
mv ${work_input}.tmp $work_input
