#!/bin/bash

if [ $1 = 1 ]; then

	./openload -l 300 http://192.168.22.128/f.php 100 >> OpenWebLoadServidor1

elif [ "$1" = "nginx" ]; then

	./openload -l 300 http://192.168.22.131/f.php 100 >> OpenWebLoadNginx

elif [ "$1" = "haproxy" ]; then

	./openload -l 300 http://192.168.22.131/f.php 100 >> OpenWebLoadHaproxy

fi
