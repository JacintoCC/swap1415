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
**Revisar los análisis de tráfico que se ofrecen en: http://bit.ly/1g0dkKj. Instalar
 wireshark y observar cómo fluye el tráfico de red en uno de los servidores web
 mientras se le hacen peticiones HTTP.**  


T5.3
----
**Buscar información sobre características, disponibilidad para diversos SO, etc de 
 herramientas para monitorizar las prestaciones de un servidor. Para empezar, 
 podemos comenzar utilizando las clásicas de Linux: top,vmstat,netstat **  
