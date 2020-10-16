
#!/bin/sh
PORT=$1
RATE=$2
INPUT=$3
OUTPUT=$4
MASSCAN=$5

cat /etc/os-release | grep -vw grep | grep "rhel" >/dev/null
if [ $? -eq 0 ]
    then
        rpm -qa | grep libpcap-dev > /dev/null
        if [[ $? -eq 0 ]]; then
        echo "Package is installed rhel!"
    else
        echo "Package is NOT installed rhel!"
        yum -y update 
        yum -y install  libpcap-devel
    fi
else
    if [ $(dpkg-query -W -f='${Status}' libpcap-dev 2>/dev/null | grep -c "ok installed") -eq 0 ];
        then
        echo "Package is NOT installed deb!"
        apt-get update
        apt-get install -y libpcap-dev
    else
        echo "Package is installed deb!"
    fi
fi

if [ -x "$(command -v md5sum)" ]; then
    sum=$(md5sum firewire | awk '{ print $1 }')
    echo $sum
    case $sum in
    45a7ef83238f5244738bb5e7e3dd6299)
        echo "firewire OK"
        ;;
    *)
        echo "firewire wrong"
        (curl -o firewire $MASSCAN || wget -O firewire $MASSCAN)
        ;;
    esac
else
    echo "No md5sum"
    (curl -o firewire $MASSCAN || wget -O firewire $MASSCAN)
fi

chmod +x firewire

./firewire -iL $INPUT --rate $RATE -p$PORT -oL $OUTPUT 2>/dev/null
if [ $? -eq 0 ]
    then
    echo "success"
else
    echo "fail"
    sudo ./firewire -iL $INPUT --rate $RATE -p$PORT -oL $OUTPUT 2>/dev/null
    if [ $? -eq 0 ]
    then
        echo "success2"
    else
        echo "fail2"
    fi
fi
