#!/bin/bash

. ./settings.sh

for $g in $groups; do
	cp $work_dir/$g.txt > $work_output
	roll_out
done
