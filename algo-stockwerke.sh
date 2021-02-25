#!/bin/bash

. ./settings.sh

echo "00er Räume"
awk -F ';' '$2 ~ /^[0-9][0-9]pc/ {print}' $work_input > $work_output
roll_out

for i in $(seq 1 7); do
	echo "$i00er Räume"
	awk -F ';' '$2 ~ /^'$i'[0-9][0-9]pc/ {print}' $work_input > $work_output
	roll_out
done
