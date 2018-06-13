# Usage NETSTAT Tool
netstat -tn

# -t = only show tcp connections
# -n = to not resolve IPs to Names


# Usage SED Tool
sed -i 's/original/new/g' file.txt
sed -i 's/\boriginal\b/new/g' file.txt

# -i = in place
# s = the substitute command
# original = a regular expression describing the word to replace (or just the word itself)
# new = the text to replace it with
# g = global (i.e. replace all and not just the first occurrence)
# /b = match word boundary
# file.txt = the file name


# Usage Uniq Tool
uniq -u file.txt

# -u = Print only Unique Lines


# Fix Locale Error (Debian Base)
locale
# locale: Cannot set LC_CTYPE to default locale: No such file or directory
# locale: Cannot set LC_ALL to default locale: No such file or directory
# LANG=en_US.UTF-8
# LANGUAGE=
# LC_CTYPE=UTF-8
# LC_NUMERIC="en_US.UTF-8"
# LC_TIME="en_US.UTF-8"
# LC_COLLATE="en_US.UTF-8"
# LC_MONETARY="en_US.UTF-8"
# LC_MESSAGES="en_US.UTF-8"
# LC_PAPER="en_US.UTF-8"
# LC_NAME="en_US.UTF-8"
# LC_ADDRESS="en_US.UTF-8"
# LC_TELEPHONE="en_US.UTF-8"
# LC_MEASUREMENT="en_US.UTF-8"
# LC_IDENTIFICATION="en_US.UTF-8"
# LC_ALL=

# Update all locale Settings if needed.
export LC_ALL="en_US.UTF-8"

# LANG=en_US.UTF-8
# LANGUAGE=
# LC_CTYPE="en_US.UTF-8"
# LC_NUMERIC="en_US.UTF-8"
# LC_TIME="en_US.UTF-8"
# LC_COLLATE="en_US.UTF-8"
# LC_MONETARY="en_US.UTF-8"
# LC_MESSAGES="en_US.UTF-8"
# LC_PAPER="en_US.UTF-8"
# LC_NAME="en_US.UTF-8"
# LC_ADDRESS="en_US.UTF-8"
# LC_TELEPHONE="en_US.UTF-8"
# LC_MEASUREMENT="en_US.UTF-8"
# LC_IDENTIFICATION="en_US.UTF-8"
# LC_ALL=en_US.UTF-8


# Switch DHCP to STATIC
sudo nano /etc/network/interfaces

# ------------------------------------------------------------------------
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
auto ens33
iface ens33 inet dhcp

# ------------------------------------------------------------------------
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
auto ens33
iface ens33 inet static
        address 192.168.xxx.xxx
        netmask 255.255.255.0
        network 192.168.xxx.0
        broadcast 192.168.xxx.255
        gateway 192.168.xxx.xxx
        dns-nameservers 192.168.xxx.xxx 192.168.xxx.xxx
# ------------------------------------------------------------------------

# Lower and Raise Inerface
sudo ifdown ens33
sudo ifup ens33