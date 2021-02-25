#!/bin/bash

. ./settings.sh

for rpc in $room_pc; do
	echo "Raum $rpc wird nun vorbereitet."
	awk -F ';' '$1 ~ /r'$rpc'/ {print}' $work_input > $work_output
	roll_out
done
