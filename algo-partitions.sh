#!/bin/bash

. ./settings.sh

while [ 0 -lt "$(wc -l $work_input | awk '{print $1}')" ]; do
	head -n $part_size $work_input > $work_output
	sed -ie "1,${part_size}d" $work_input
	roll_out
done
