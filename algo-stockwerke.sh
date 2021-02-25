#!/bin/bash

. ./settings.sh

awk -F ';' '$2 ~ /^[0-9][0-9]pc/ {print}' $work_input > $work_output
roll_out

for i in $(seq 1 7); do
	awk -F ';' '$2 ~ /^'$i'[0-9][0-9]pc/ {print}' $work_input > $work_output
	roll_out
done
