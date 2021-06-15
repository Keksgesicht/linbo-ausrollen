#!/bin/bash

echo "running linbo-remote with \"$linbo_params\""

IFS=$'\n'
for line in $(cat $work_output); do
	client_name=$(echo $line | awk -F ';' '{print $2}')
	client_mac=$(echo $line | awk -F ';' '{print $4}')

	wakeonlan $client_mac >/dev/null
	for lp in $linbo_params; do
		eval sudo screen -dm -S linbo_ausrollen_${client_name} $linbo_exec -i $client_name $lp
	done
	wakeonlan $client_mac >/dev/null
done
unset IFS

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

cleanup
