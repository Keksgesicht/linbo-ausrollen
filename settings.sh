#!/bin/bash

# output coloring
NC='\033[0m' # No Color
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

# work directories
work_pc="/etc/linuxmuster/sophomorix/default-school/devices.csv"
work_dir="/tmp/ausrollen"
debug_dir="/tmp/ausrollen_debug"

work_all="$work_dir/all.txt"
work_input="$work_dir/groups.txt"
work_output="$work_dir/roll.txt"

# exec parameter
linbo_exec="/usr/sbin/linbo-remote"
linbo_params_sync="-w 600 -b 0 -p format:1,sync:1,start:1"
linbo_params_start=$(echo -e "-w 100 -b 0 start:1\n-c start:1")
linbo_params_linbo="-w 100 -c start:0"
linbo_params_wipe="-w 600 -b 0 -p format,sync:1,start:1"

case $1 in
	'-start')
		linbo_params=$linbo_params_start
		shift
	;;
	'-sync')
		linbo_params=$linbo_params_sync
		shift
	;;
	'-linbo')
		linbo_params=$linbo_params_linbo
		shift
	;;
	'-wipe')
		linbo_params=$linbo_params_wipe
		shift
	;;
	*)
		linbo_params=$linbo_params_sync
	;;
esac

groups="win10fs2 win10edu"

# cleanup and preparation
cleanup() {
	rm -r $work_dir 2>/dev/null
}
cleanup

# preparation
mkdir $work_dir 2>/dev/null
cat $work_pc | sort -t';' -nk2 > $work_all
truncate -s 0 $work_input
for g in $groups; do
	grep $g $work_all > $work_dir/$g.txt
	cat ${work_dir}/${g}.txt >> $work_input
done
sort -t';' -nk2 $work_input > ${work_input}.tmp
mv ${work_input}.tmp $work_input
