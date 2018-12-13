#!/bin/bash



function askip {
    read -r -p "select: [1] all scanable IPs [2] specific IPs [q] quit: " response
    case $response in
    [1])
        all_ips
        ;;
    [2])
        select_ips
        ;;
    [q])
        exit
        ;;
    esac
}

function askuser {
    prompt="Enter Username:"
        while IFS= read -p "$prompt" -r -s -n 1 char1
        do
            if [[ $char1 == $'\0' ]]
            then
                break
            fi
            prompt='*'
            username+="$char1"
        done
        echo ""
    
        prompt="Enter Password:"
        while IFS= read -p "$prompt" -r -s -n 1 char2
        do
            if [[ $char2 == $'\0' ]]
            then
                break
            fi
            prompt='*'
            password+="$char2"
        done
        echo ""
}

function all_ips {
    askuser
    echo $username $password
#    for x in {50..60}; do
#        ping -q -c 1 -W 100 192.168.3.$x > /dev/null
#        if [ $? = 0 ];
#        then
#            sshpass -p $password ssh -o StrictHostKeyChecking=no $username@$x
#            eth=`networksetup -listallnetworkservices | grep "^Ethernet"`
#        if [ -z $eth ];
#        then
#            echo "no suitable Adapter found"
#        else
#            echo $eth
#        fi
#        else
#            echo "no active IP"
#        fi
#    done
}



askip