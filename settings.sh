#!/bin/bash

export work_pc="/etc/linuxmuster/workstations"
export work_dir="/tmp/ausrollen"

export work_all="$work_dir/all.txt"
export work_input="$work_dir/groups.txt"
export work_output="$work_dir/roll.txt"

export linbo_exec="/usr/sbin/linbo-remote"
export linbo_params="-w 1000 -b 0 -p format,sync:1,start:1"
# -w 1000 -b 0 -p format,sync:1,start:1
# -w 60 -b 0 start:1
# -c start:1

export groups="win10fs2 win10smart"
export room_pc="306 611 612"

export interval="300s"
export part_size="20"

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
cat $work_pc | sort > $work_all

truncate -s 0 $work_input
for g in $groups; do
	grep $g $work_all > $work_dir/$g.txt
	cat $work_dir/$g.txt >> $work_input
done
