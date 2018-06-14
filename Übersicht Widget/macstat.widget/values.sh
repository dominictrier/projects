networksetup -getcomputername
ifconfig | grep 'inet ' | grep -v -m1 127.0.0.1 | awk -F' ' '{print $2}'
if nc -4 -z -w5 -G5 www.reddit.com 443 > /dev/null 2>&1 == 0; then echo 'avaiable'; else echo 'not available'; fi
netstat -nr | grep -m1 default | awk -F' ' '{print $2}'
system_profiler SPNetworkLocationDataType | grep -A999 'Active Location: Yes' | grep -E -A999 'Type: Ethernet|IEEE80211' |grep -A999 'IPv4' | grep -m1 'Configuration Method:' | awk -F': ' '{print $2}'