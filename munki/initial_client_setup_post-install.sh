#!/bin/bash

# Write all Output to Log File
exec >> /installlog.txt 2>&1

# run initial_setup script
bash /initial_tmp/client_setup.sh

# wait for 10sec to let client setup finish
sleep 10

# remove Temp directory
rm -rf /initial_tmp

# put setup done file into place
touch /.initial_setup_done

exit 0 
