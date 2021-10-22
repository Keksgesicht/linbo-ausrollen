#!/bin/bash

. "$(dirname $0)"/settings.sh
tmp_file=$work_dir/host.txt

for host in $@; do
	awk -F ';' '$2 ~ /^'$host'$/ {print}' $work_input > $tmp_file
	if [ -z "$(cat $tmp_file)" ]; then
		echo "Kein PC mit $host gefunden!"
	fi
	cat $tmp_file >> $work_output
done

. "$(dirname $0)"/ausrollen.sh
