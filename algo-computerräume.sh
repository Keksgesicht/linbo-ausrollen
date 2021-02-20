#!/bin/bash

. ./settings.sh

for rpc in $room_pc; do
	cp $work_input $work_output
	roll_out
done
