#!/bin/bash

ifconfig wlx8416f9158146 down
iw dev wlx8416f9158146 set type managed
ifconfig wlx8416f9158146 up

debugfs="/sys/kernel/debug/ieee80211/phy0/ath9k_htc/"

echo 200 > ${debugfs}spectral_count
cat ${debugfs}spectral_count
echo chanscan > ${debugfs}spectral_scan_ctl
cat ${debugfs}spectral_scan_ctl

time=`date "+%H:%M:%S-%y%m%d"`

samples_dir="/home/test/ath-spectral-scan/samples/test/"

while :
do
    iw dev wlx8416f9158146 scan
    sample_file=${samples_dir}test-${time}
    cat ${debugfs}spectral_scan0 > ${sample_file}
done
