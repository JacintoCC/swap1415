#!/bin/bash

if [ $1 = 1 ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> ApacheBenchmarkServidor1
		ab -n 1000 -c 50 http://192.168.22.128/f.php >> ApacheBenchmarkServidor1
	done

elif [ "$1" = "nginx" ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> ApacheBenchmarkNginx
		ab -n 1000 -c 50 http://192.168.22.131/f.php >> ApacheBenchmarkNginx
	done

elif [ "$1" = "haproxy" ]; then

	for ((i=0;i<5;i++));
	do
		echo -e "\nEsta es la ejecución $i" >> ApacheBenchmarkHaproxy
		ab -n 1000 -c 50 http://192.168.22.131/f.php >> ApacheBenchmarkHaproxy
	done

fi
