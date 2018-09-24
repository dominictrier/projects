#!/bin/bash

# check FTP Server contionusly for Upload and Download Speeds every 5 Minutes and write Results into Logfile - v1
# File for Upload and download needs to be provided. on Upload the File on Server will be overwriten, Downloaded File will be send to /dev/null.
# tools wget and wput are required (on macos wget and wput can be installed via Homebrew)
# Last Modified Tue, 24.09.2018 by Dominic (dominic.trier@gmail.com)

# define variables
lfn="wpuget.log.txt"                # Logfile Name
lfloc="$HOME/Desktop/"              # Logfile Location
ftpu="ftp.domain.com"               # FTP URL
ftpp="/automated_test/"             # FTP Path
ftpusr="username"                   # FTP User
ftppw="password"                    # FTP Password
tfn="testfile.zip"                  # Testfile Name
tfloc="$HOME/Desktop/"              # Testfile Location
stime=300                           # Sleep Time

# run wget and wput test and echo result back to main shell
test_upload () {
  ul_val_local=$(wput -u --basename="${tfloc}" "${tfloc}""${tfn}"  ftp://"${ftpusr}":"${ftppw}"@"${ftpu}""${ftpp}" | grep "Transfered" | cut -f8- -d" ")
  echo "${ul_val_local}"
}
test_download () {
  dl_val_local=$(wget --ftp-user="${ftpusr}" --password="${ftppw}" -O /dev/null ftp://"${ftpu}""${ftpp}""${tfn}" 2>&1 | tail -2 | sed 's/.*(\(.*\)).*/\1/' )
  echo "${dl_val_local}"
}

# echo test description and sleep time
echo "this script will run WGET and WPUT every ${stime} seconds and log the results, press CTRL+C to cancel"
echo "Start Test @ $(date)"

# check for logfile, clean if available, create if not
if [[ "${lfloc}""${lfn}" ]]; then
  echo "" > "${lfloc}""${lfn}"
else
  touch "${lfloc}""${lfn}"
fi

# run continous test, echo to shell and append logfile
while true; do
  echo "$(date) UL $(test_upload)" | tee -a "${lfloc}""${lfn}"
  echo "$(date) DL $(test_download)" | tee -a "${lfloc}""${lfn}"
  echo ""
  sleep "${stime}"
done
