#!/bin/bash

. "$(dirname $0)"/settings.sh
tmp_file=$work_dir/raum.txt

for r in $@; do
	awk -F ';' '$1 ~ /^'$r'$/ {print}' $work_input > $tmp_file
	if [ -z "$(cat $tmp_file)" ]; then
		echo "Kein Raum $r gefunden!"
	fi
	cat $tmp_file >> $work_output
done

. "$(dirname $0)"/ausrollen.sh
