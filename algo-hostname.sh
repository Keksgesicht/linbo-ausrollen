#!/bin/bash

. ./settings.sh

for host in $@; do
	echo "dummy;$host;dummy" >> $work_output
done

. ./ausrollen.sh
