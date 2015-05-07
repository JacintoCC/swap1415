#!/bin/bash

if [ $1 = 1 ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> HttperfServidor1
		httperf --server 192.168.22.128 --port 80 --uri /f.php --rate 50 --num-conn 500 --num-call 1 >> HttperfServidor1
	done

elif [ "$1" = "nginx" ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> HttperfNginx
		httperf --server 192.168.22.131 --port 80 --uri /f.php --rate 50 --num-conn 500 --num-call 1 >> HttperfNginx
	done

elif [ "$1" = "haproxy" ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> HttperfHaproxy
		httperf --server 192.168.22.131 --port 80 --uri /f.php --rate 50 --num-conn 500 --num-call 1 >> HttperfHaproxy
	done

fi
