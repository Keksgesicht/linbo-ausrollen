#!/bin/bash

echo "running linbo-remote with \"$linbo_params\""
for pc in $(awk -F ';' '{print $2}' $work_output); do
	IFS=$'\n'
	for lp in $linbo_params; do
		eval sudo screen -dm -S linbo_ausrollen_$pc $linbo_exec -i $pc $lp
	done
	unset IFS
done

sleep 1s

failed_pc=""
for pc in $(awk -F ';' '{print $2}' $work_output); do
	sudo screen -ls | grep -q linbo_ausrollen_$pc || \
	failed_pc+="$pc "
done

if [ -n "$failed_pc" ]; then
	echo "Bei folgenden PCs ist ein Fehler aufgetreten:"
	echo "$failed_pc"
fi
