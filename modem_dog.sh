#!/bin/bash

now=$(date)

getscript() {
  pgrep -lf ".[ /]$1( |\$)"
}
if getscript "multi_https_connect" >/dev/null; then
	echo "Cimel connect is running at ${now} >> $HOME/logs/connection.log
else
	echo "Cimel connect is not running at ${now} >> $HOME/logs/connection.log
fi

is_ppp=0
text=`sudo ifconfig | grep ppp0`
if [ -n "$text" ]; then
	text=`sudo ifconfig ppp0 | grep "inet addr"`
	if [ -n "text" ]; then
		is_ppp=1
	fi
fi
echo "Connection is: ${is_ppp} at ${now}" >> $HOME/logs/connection.log

sudo /usr/local/bin/hologram network disconnect
sleep 20

sudo /usr/local/bin/hologram modem reset
sleep 180

sudo /usr/local/bin/hologram network connect
sleep 10

echo "Executed modem disconnect, reset and connect at ${now}"  >> $HOME/logs/mdmlog.log
