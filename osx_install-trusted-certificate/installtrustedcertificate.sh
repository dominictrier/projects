#!/bin/sh


# V1 ARD install certificate Script. Last Modified Mon, 08.03.2017 by Dom (dominic.trier@gmail.com)
# - initial release

# copy certificate with ARD to $temp_loc location
# run script with "UNIX Command" as ROOT in ARD

# declare array to provide possible usernames
declare -a arr=("user1" "user2" "user3")

# set variable for temporary location
temp_loc="/path/to/templocation"

# loop through all usernames in array
for username in "${arr[@]}"; do
    # check with grep if user=true
    if dscl . -read /Users/"$username" 2>/dev/null | grep -qs "/Users/""$username" ; then
        # install selected certificate as admin/root into user login.keychain
        security add-trusted-cert -d -r trustRoot -k /Users/"$username"/Library/Keychains/login.keychain "$temp_loc""/certificate.crt"
        # echo success
        echo "user" "$username" "found. -installing certificate"
    fi
done

# delete temp certificate storage
cd / && rm -rf "$temp_loc"