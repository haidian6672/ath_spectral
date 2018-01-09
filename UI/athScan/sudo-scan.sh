#!/bin/bash
interface="wlx485d602a436f"
ifconfig ${interface} down
rfkill unblock wifi
iw dev ${interface} set type managed
ifconfig ${interface} up

debugfs="/sys/kernel/debug/ieee80211/phy5/ath9k_htc/"
samples_dir="/home/test/ath-spectral-scan/samples/test/"

echo 200 > ${debugfs}spectral_count
cat ${debugfs}spectral_count

while :
do
    echo chanscan > ${debugfs}spectral_scan_ctl
    cat ${debugfs}spectral_scan_ctl
    iw dev ${interface} scan
    echo disable > ${debugfs}spectral_scan_ctl
    
    time=`date "+%H:%M:%S-%y%m%d"`
    sample_file=${samples_dir}test-${time}
    cat ${debugfs}spectral_scan0 > ${sample_file}

    sleep 1s
done
