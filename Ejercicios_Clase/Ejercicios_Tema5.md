Ejercicios Tema 5  
=================  

T5.1  
----  
**Buscar información sobre cómo calcular el número de conexiones por segundo.**  
Si tenemos un servidor Nginx, podemos calcular fácilmente gracias a un módulo
 de Nginx el número de conexiones por segundo. En primer lugar tenemos que activar
 la recopilación de estadísticas en el fichero `nginx.conf` añadiendo la sentencia
 `stub_status on` en `location /nginx_status`y hacerla accesible sólo para la 
 máquina del administrador. Entonces tendremos disponible en el navegador agregando
 a la dirección de la página cuyo estado queremos comprobar "/nginx_status"
 el número de conexiones abiertas, de conexiones aceptadas, manejadas, y peticiones
 manejadas. Si dividimos el número de peticiones manejadas entre el número de
 conexiones manejadas, tendremos el número de conexiones abiertas por segundo.  
Otra forma de comprobar el número de conexiones es con `netstat | grep -c http`, es
 decir, estamos mostrando la salida correspondiente a las conexiones de red,
 tablas de enrutamiento y estadísticas, y buscando (y contando) las conexiones
 relativas al protocolo HTTP.

T5.2  
----  
**Revisar los análisis de tráfico que se ofrecen en: http://bit.ly/1g0dkKj. Instalar Wireshark y observar cómo fluye el tráfico de red en uno de los servidores web mientras se le hacen peticiones HTTP.**  
Hemos hecho una prueba para pedir con siege una página html al balanceador y capturar el tráfico (10 paquetes) que pasa a través del balanceador con Tshark.
![Tshark](https://github.com/JacintoCC/swap1415/blob/master/Ejercicios_Clase/T5.2.png)

T5.3  
----  
**Buscar información sobre características, disponibilidad para diversos SO, etc de herramientas para monitorizar las prestaciones de un servidor. Para empezar, podemos comenzar utilizando las clásicas de Linux: top, vmstat, netstat**  

Con top podemos tener una vista dinámica de un sistema en funcionamiento. Puede mostrar un resumen y una lista de procesos manejados por el kernel Linux. Tiene una limitada interfaz interactiva y una interfaz más amplia para la configuración personal.  
vmstat muestra información sobre procesos, memoria, discos, E/S y actividad de la CPU.
netstat muestra conexiones de red, tablas de enrutamiento, las máscaras de las diferentes conexiones y estadísticas de las diferentes interfaces.

