#!/bin/bash

. ./settings.sh

grep ";[0-9][0-9]pc" $work_input > $work_output
roll_out

for i in $(seq 1 7); do
	grep ";${i}[0-9][0-9]pc" $work_input > $work_output
	roll_out
done
