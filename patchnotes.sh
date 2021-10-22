#!/bin/bash

. "$(dirname $0)"/settings.sh
file_prefix=$(dirname $0)/$(basename $0 .sh)

for group in $groups; do
	group_file=${file_prefix}_${group}.txt
	cp ${group_file} ${group_file}.old
	tmp_file=$(mktemp)
	diff_file=$(mktemp)

	for image_file in $(ls /var/linbo/${group}*.cloop.desc); do
		basename $image_file >> $tmp_file
		stat -c %y $image_file >> $tmp_file
		cat $image_file >> $tmp_file
		echo -e "\n" >> $tmp_file
	done

	diff -e $group_file $tmp_file | egrep -v '^([0-9]+,)?[0-9]+d$' > $diff_file
	(cat $diff_file && echo w) | ed - $group_file
	rm $tmp_file $diff_file
done

cleanup
