Práctica 4
==========

Realizada por Jacinto Carrasco Castillo y Anabel Gómez Ríos.  
En esta práctica hemos comprobado el rendimiento de la granja web tanto en VMWare con máquinas con Ubuntu 12.04 como en VirtualBox con máquinas con Ubuntu 14.04. Las peticiones han de hacerse en una máquina aparte de la granja web, ya que crear las peticiones es de por sí una carga. En VirtualBox hemos necesitado crear una máquina Cliente nueva, en VMWare hemos utilizado simplemente la máquina anfitriona. Los tres programas que hemos utilizado para medir el rendimiento han sido Apache Benchmark, HTTPerf y OpenWebLoad. La página web que hemos pedido en todos los casos ha sido el script facilitado por el profesor, f.php, que es el siguiente:  
`<?php`  
  
`$tiempo_inicio = microtime(true);`  
  
`for ($i=0; $i<3000000; $i++){`  
 `$a = $i * $i;`  
 `$b = $a - $i;`  
 `$c = $a / $b;`  
 `$d = 1 / $c;`  
`}`  
  
`$tiempo_fin = microtime(true);`  
  
`echo "Tiempo empleado: " . round($tiempo_fin - $tiempo_inicio, 4) ;`   
  
`?>`  
  
Apache Benchmark
----------------
  
El script que hemos utilizado para lanzar ab ha sido el fichero [scriptApacheBenchmark.sh](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/scriptApacheBenchmark.sh) que hay en esta misma carpeta. Lo hemos lanzado 5 veces en cada caso con una carga de 1000 peticiones de 50 en 50.  
Los resultados en VMWare han sido los siguientes: 
   
![DatosABVM](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosABVM.png)  
![TimeTakenForTests](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TimeTakenForTests.png)  
![FailedRequests](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/FailedRequests.png)  
![RequestsPerSecond](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/RequestsPerSecond.png)  
![TimePerRequest](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TimePerRequest.png)  
Los resultados en VirtualBox han sido los siguientes:  
![DatosABVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosABVB.png)  
![RequestsPerSecond&TimePerRequest](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/RequestsPerSecond%26TimePerRequest.png)  
![TimeTakenForTests&FailedRequests](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TimeTakenForTests%26FailedRequests.png)  
  
HTTPerf
---------
  
El script que hemos utilizado para lanzar httperf ha sido el fichero [scriptHttperf.sh](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/scriptHttperf.sh) que hay en esta misma carpeta. Lo hemos lanzado 5 veces en cada caso con una carga de 500 peticiones tcp con 50 llamadas http cada una.  
Los resultados en VMWare han sido los siguientes:  
  
![DatosHttperfVM](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosHttperfVM.png)  
![TotalConnections](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TotalConnections.png)  
![Replies](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/Replies.png)  
![RequestRate](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/RequestRate.png)  
![Errors](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/Errors.png)  
Los resultados en VirtualBox han sido los siguientes:  
![DatosHttperfVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosHttperfVB.png)  
En este caso no hemos hecho gráficas porque como vemos todos los valores han salido iguales.  
  
OpenWebLoad
------------
  
El script que hemos utilizado para lanzar OpenWebLoad ha sido el fichero [scriptOpenWebLoad.sh](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/scriptOpenWebLoad.sh) que hay en esta misma carpeta. Lo hemos lanzado una vez, durante 5 minutos en cada caso.  
  
Los resultados en VMWare han sido los siguientes:  
![DatosOPLWM](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosOPLVM.png)  
![TotalTPS](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TotalTPS.png)  
![AvgResponseTime](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/AvgResponseTime.png)  
![MaxResponseTime](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/MaxResponseTime.png)  
Los resultados en VirtualBox han sido los siguientes:  
![DatosOPLVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/DatosOPLVB.png)  
![TotalTPSVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/TotalTPSVB.png)  
![AvgResponseTimeVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/AvgResponseTimeVB.png)  
![MaxResponseTimeVB](https://github.com/AnabelGRios/swap1415/blob/master/Practicas/Practica4/img/MaxResponseTimeVB.png)  
  
Conclusiones
--------------
  
Httperf nos ha dado algunos problemas, como se puede ver en el caso de las baterías de pruebas en VirtualBox. Por lo demás, los resultados son más o menos los esperados, tardando menos con los balanceadores que en el servidor solo. Vemos también que HaProxy es mejor balanceador que Nginx, ya que los tiempos son siempre mejores.
