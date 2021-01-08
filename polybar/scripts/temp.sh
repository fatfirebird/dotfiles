#!/bin/sh
case "$1" in
	--popup)
		notify-send  "$(sensors)"
		;;
	*)
echo	" $(sensors | grep temp1 | head -1 | awk '{print $2}')"
	;;
esac
