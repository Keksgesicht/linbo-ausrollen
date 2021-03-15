#!/bin/bash

. ./settings.sh
tmp_file=$work_dir/gruppe.txt

for g in $@; do
	awk -F ';' '$1 ~ /^'$g'$/ {print}' $work_input > $tmp_file
	if [ -z "$(cat $tmp_file)" ]; then
		echo "Keine Gruppe $g gefunden!"
	fi
	cat $tmp_file >> $work_output
done

. ./ausrollen.sh