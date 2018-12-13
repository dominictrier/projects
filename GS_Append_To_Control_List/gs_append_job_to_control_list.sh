#!/bin/bash

# Add from Goodsync Transported Job to Control Text File
# This Replaces the Google Transport App
# Arguments Provided by Goodsync are Target Directory and Job Start Time

# maintainer: dominic.trier@gmail.com
# initial: 11.12.2018

#get arguments (target directory & job time)
tdir=$1
jtme=$2

#control file name
cfname="control.txt"

# job starting time (Month + Day, hour + min)
jtme_val1=${jtme:2:2}${jtme:4:2}
jtme_val2=${jtme:7:2}${jtme:9:2}

# compare folder / job time and write to control text file if same or newer.
for folder in "${tdir}"/*/ ; do
    modt=$(date -r "${folder}" "+%m%d%H%M")
    modt_val1="${motd:0:4}"
    modt_val2="${motd:4:4}"
    nwname="${tdir}/&\$_$(basename "${folder}")"
    if [[ ${jtme_val1} -eq ${modt_val1} && ${jtme_val2} -ge ${modt_val2} ]]; then
      echo -e "$(basename "${folder}")" | tee -a "${tdir}/${cfname}"
    else
      :
    fi
done
