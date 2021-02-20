#!/bin/bash

for pc in $(awk -F ';' '{print $2}' $work_output); do
	sudo screen -dm -S linbo_remote_$pc $linbo_exec -i $pc $linbo_params
done
