#!/bin/bash

. "$(dirname $0)"/settings.sh
output_dir="/home/administrators/pgmadmin/veyon_locations"

mkdir $output_dir

# Location: win10fs2
cat ${work_input} | \
awk -F ";" '$3 ~ /^win10fs2$/ {print $2,$5,$4}' | \
tr ' ' ';' >${output_dir}/veyon_fs2.csv

# Location: win10smart
cat ${work_input} | \
awk -F ";" '$3 ~ /^win10smart$/ {print $2,$5,$4}' | \
tr ' ' ';' >${output_dir}/veyon_smart.csv

# Location: 0. Stock
cat ${work_input} | \
awk -F ";" '$1 ~ /^r[0-9][0-9]$/ {print $2,$5,$4}' | \
sort -nk1 | \
tr ' ' ';' >${output_dir}/veyon_00.csv

# Location 1.-7. Stock
for i in $(seq 1 7); do
	cat ${work_input} | \
	awk -F ";" '$1 ~ /^r'${i}'[0-9][0-9]$/ {print $2,$5,$4}' | \
	sort -nk1 | \
	tr ' ' ';' >${output_dir}/veyon_${i}00.csv
done

# Location: r306
cat ${work_input} | \
awk -F ";" '$1 ~ /^r306$/ {print $2,$5,$4}' | \
sort -nk1 | \
tr ' ' ';' >${output_dir}/veyon_306.csv

# Location: r611
cat ${work_input} | \
awk -F ";" '$1 ~ /^r611$/ {print $2,$5,$4}' | \
sort -nk1 | \
tr ' ' ';' >${output_dir}/veyon_611.csv

# Location: r612
cat ${work_input} | \
awk -F ";" '$1 ~ /^r612$/ {print $2,$5,$4}' | \
sort -nk1 | \
tr ' ' ';' >${output_dir}/veyon_612.csv

# copy import script
cp "$(dirname $0)"/veyon_import.bat ${output_dir}/
rm /tmp/ausrollen/*
