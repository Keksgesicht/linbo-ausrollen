#!/bin/bash

. ./settings.sh

while true; do
	head -n $part_size $work_input > $work_output
	sed -ie "1,${part_size}d" $work_input
	roll_out
done
