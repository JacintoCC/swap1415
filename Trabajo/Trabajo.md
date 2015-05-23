
Trabajo realizado por:    
Anabel Gómez Ríos  
Jacinto Carrasco Castillo  

Resumen:  
========


En este trabajo vamos a ver algunos de los algoritmos más utilizados en el balanceado de carga por software, y los vamos a probar con Siege en dos software diferentes: Nginx y HaProxy en una granja web virtualizada de 4 servidores con software Ubuntu Server 12.04, en las que no todas van a tener las mismas especificaciones.  

Algoritmos de balanceo de carga:  
===========================

Pasamos por tanto a ver los algoritmos de balanceo de carga más utilizados, y los que vamos a utilizar nosotros en nuestra granja para probarlos.  

**Por turnos o Round-Robin**   
El balanceador manda las peticiones a los servidores de la granja web por turnos, de forma que manda una petición a cada servidor empezando por el primero y, cuando ha mandado una a cada uno, empieza de nuevo con el primero, de forma que todos los servidores reciben el mismo número de peticiones. Es el algoritmo más sencillo de implementar y funciona bien si todas las máquinas tienen las mismas características o son muy parecidas. De no ser así, las máquinas con menor capacidad irán sobrecargándose y dejarán de servir las peticiones. Además, este algoritmo no contempla que esto ocurra, por lo que seguirá mandando peticiones a las máquinas que están caídas. Esto conlleva un gran número de peticiones no servidas que normalmente no se puede permitir.  

**Basado en el menor número de conexiones**   
Con este algoritmo, el balanceador lleva la cuenta interna del número de conexiones que ha habido a cada servidor y del número de peticiones que ya ha servido. Así, el balanceador manda las nuevas peticiones a los servidores que tienen el menor número de trabajos terminados. Este algoritmo tiene un problema muy parecido al anterior, y es que tampoco contempla que una de las máquinas se sobrecargue, de forma que si lo hace, será la máquina que menos trabajos terminados tenga y será a la que se le envíen las peticiones pendientes, pero al estar sobrecargada no las atenderá, por lo que se perderán todas. De nuevo, este algoritmo funciona si las máquinas son igual de potentes.  

**Ponderación**  
Con este algoritmo podemos asignar una ponderación a cada servidor, de forma que los servidores con mayor puntuación recibirán un mayor número de peticiones. Asignamos así el tanto por ciento de peticiones que servirá cada servidor. Por ejemplo, si tenemos tres servidores, dos con ponderación 1 y otro con ponderación 2, el último servidor recibirá el 50% de las peticiones que se envíen, mientras que los otros dos recibirán el 25% cada uno. Como vemos, este algoritmo sí tiene en cuenta que las máquinas no sean igualmente potentes, por lo que podemos comprobar qué máquinas tenemos que sean más potentes que otras y darles mayor carga de trabajo a estas. Es la solución más fácil si los dos algoritmos anteriores no funcionan por este motivo.  

**Prioridad**   
Con este algoritmo podemos hacer grupos de servidores, de forma que asignamos una prioridad y un número máximo de peticiones a cada grupo, pero no servidor a servidor. Dentro de cada grupo lo más usual es utilizar el algoritmo round-robin, pero se podría implementar cualquier otro. De esta forma, si un grupo recibe más peticiones de las que tiene establecidas, entonces el siguiente grupo con más prioridad pasa a recibirlas. Por ejemplo, supongamos que tenemos tres grupos, A, B y C, de forma que los grupos A y B tienen prioridad 1 y el grupo C tiene prioridad 2. Entonces, el balanceador comenzará mandando las peticiones al grupo A hasta que se complete su número máximo de conexiones, momento en el que pasa a mandar las peticiones al grupo B, de nuevo hasta completar el número de conexiones. En este momento, si el grupo A se ha liberado de su carga, el balanceador volverá a mandar tantas peticiones como tenga establecidas al grupo A y de nuevo al grupo B si éste se ha liberado. Así, el balanceador no mandará carga al grupo C hasta que los grupos A o B se sobrecarguen, dejando tiempo para que se liberen.  

**Tiempo de respuesta**  
Este algoritmo se basa en el hecho de que si una petición tarda más en un servidor que en otro, será porque ese servidor está más sobrecargado que el resto. De esta forma, el balanceador va calculando los tiempos de respuesta de cada servidor y en base a eso decide a cuál de ellos enviar la siguiente petición.  

**Combinación de tiempo de respuesta y menor número de conexiones**
A partir de aquí, se pueden hacer tantas combinaciones de los algoritmos anteriores como sean posibles. Una de las combinaciones posibles es la que aquí comentamos, del tiempo de respuesta y del número de conexiones, de forma que si dos o más servidores han tardado lo mismo en servir una petición, se decide en base al número de conexiones que haya tenido cada una.  

Especificaciones de las máquinas  
===========================
Como hemos mencionado anteriormente, no todas las máquinas van a tener las mismas características, en concreto, son las siguientes (indicamos también las IPs de cada una, ya que aparecerán en la implementación de los algoritmos):  

 - Máquina 1: 192.168.22.128 - 512 MB de memoria, 1 procesador  
 - Máquina 2: 192.168.22.130 - 512 MB de memoria, 1 procesador  
 - Máquina 3: 192.168.22.132 - 1 GB de memoria, 2 procesadores  
 - Máquina 4: 192.168.22.134 - 256 MB de memoria, 1 procesador  

Estas 4 máquinas serán los servidores de la granja web. Además, tendremos una máquina distinta que será el balanceador desde la que distribuiremos la carga.  

Implementación de los algoritmos  
============================

Como hemos comentado, la idea es implementar los algoritmos anteriores tanto en Nginx como en HaProxy, pero ambos software tienen implementados ya por defecto una serie de algoritmos que podremos modificar con las directivas especificadas en cada uno de ellos. Por esto, no hemos podido implementar tal cual están explicados más arriba algunos de los algoritmos vistos en clase, pero hemos intentado que se parezcan lo más posible y comentaremos en cada caso las diferencias. Además, tanto Nginx como HaProxy ofrecen una gran cantidad de directivas para hacer muchas combinaciones de algoritmos, por lo que al final comentaremos también otras opciones que hemos probado.  

Por otro lado, nos hemos encontrado con que algunas de las directivas de Nginx están sólo sucribiéndose (y pagando) a Nginx Plus, pero también permite descargar una versión de prueba de 30 días, que es lo que hemos utilizado nosotros para hacer el trabajo.  

Comprobación del rendimiento:  
Para probar el rendimiento de todos los algoritmos hemos utilizado el software Siege. Siege se puede instalar en ubuntu simplemente con la orden `sudo apt-get install siege`. Le hemos dado la carga suficiente para que empezara a haber fallos con el algoritmo más simple (round robin) para poder comprobar si mejoran los tiempos y la disponibilidad de la granja con el resto de algoritmos. En concreto hemos utilizado 80 usuarios concurrentes y hemos pedido el script f.php utilizado en la práctica 4 durante 2 minutos cada ejecución. Hemos realizado 10 ejecuciones y hecho la media de los valores más importantes. Por lo tanto, la orden en Siege es `siege -b -t120s -c 80 -v 192.168.22.131/f.php`.  
El script que hemos utilizado para realizar las pruebas es una versión de [éste](https://github.com/analca3/SWAP1415/blob/master/Pr%C3%A1ctica%204%20-%20Comprobar%20el%20rendimiento%20de%20servidores%20web/Scripts/ab.sh) y se puede encontrar en esta misma carpeta (siege.sh).  

Interpretación de los resultados  
==========================
La salida de siege es de la siguiente forma:  

![salidaSiege1](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/salidaSiege1.png)  
![salidaSiege2](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/salidaSiege2.png)  

Donde vemos que nos da la disponibilidad que ha tenido la granja, el tiempo que ha estado ejecutándose, la cantidad de datos que se han transferido, el tiempo medio de respuesta y el número de peticiones por segundo que se han hecho (transaction rate). Además nos muestra el número de peticiones que han tenido éxito y las que no. Podemos ver también los segundos que ha tardado la petición más larga y los que ha tardado la petición más corta.  

Para hacer las pruebas hemos recopilado la disponibilidad (availability), el tiempo medio de respuesta (response time), el número de peticiones por segundo (transaction rate) y el tiempo que ha llevado la petición que más ha tardado (longest transaction).  

Implementación  y resultados de los algoritmos en Nginx:  
=============================
Pasamos por lo tanto a ver la implementación de los algoritmos en Nginx:  

**Round Robin**: Es el algoritmo por defecto si no se especifica nada más, por lo que sólo tendremos que especificar las IPs de nuestras 4 máquinas en la sección upstream. En concreto, el fichero de configuración localizado en `/etc/nginx/conf.d/default.conf` es:  

![(roundrobin)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(roundrobin)nginx.png)  

Los resultados obtenidos han sido los siguientes (en media):  
Availability: 67,92 %  
Longest Transaction: 26,75  
Response Time: 7,558  
Transaction Rate: 3,209  

**Basado en el menor número de conexiones**: Este algoritmo está implementado sólo poniendo la directiva `least_conn`, pero no es exactamente el que hemos explicado al principio del trabajo, sino que es una versión mejorada del mismo, de forma que envía la siguiente petición al servidor con menor número de conexiones activas. Así, si un servidor está sobrecargado, tendrá más conexiones activas y no se le enviará, a diferencia del explicado anteriormente.  
La configuración es la siguiente:  

![(least_conn)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(least_conn)nginx.png)  

Y  los resultados han sido los siguientes (en media):  
Availability: 97,54 %  
Longest Transaction: 27,53  
Response Time: 12,06  
Transaction Rate: 5,848  

**Ponderación**: Es el round robin con pesos y se puede implementar igual utilizando la directiva `weight`.
La configuración es la siguiente (hemos dado los pesos en función de las capacidades de las máquinas):  

![(ponderacion)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(ponderacion)nginx.png)  

Y los resultados (en media) han sido:  
Availability: 75,39 %  
Longest Transaction: 28,21  
Response Time: 8,296  
Transaction Rate: 3,963  

**Prioridad**: Este algoritmo no hemos podido implementarlo tal y como viene explicado al principio del trabajo ya que, aunque se pueden definir diferentes grupos con upstream, no podemos darle una prioridad a cada uno y que ambos balanceen de la misma localización. Hemos encontrado que esto sirve para filtrar por localización, por ejemplo, si la petición llega desde España, se envía al primer grupo de servidores, que sirven la página en español, pero si llega desde Estados Unidos, se envía al segundo grupo de servidores, que la enviarán en inglés. Así pues, hemos implementado dicho algoritmo lo más parecido posible pero sin los grupos, es decir, hemos puesto la segunda máquina como backup, de forma que sólo se le enviarán peticiones cuando los demás fallen, y ponemos que las demás máquinas se marcarán como caídas cuando tengan 3 fallos en 5 segundos (y estarán marcadas como caídas durante 5 segundos). Además, le damos como número máximo de conexiones a la primera y a la segunda máquina 25, a la tercera 50 y a la última 10, lo que sólo es posible en Nginx Plus, que es el que tiene la directiva max_conns.  
La configuración es la siguiente:  

![(prioridad)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(prioridad)nginx.png)  

Y los resultados (en media) han sido:  
Availability: 97,86 %  
Longest Transaction: 26,36  
Response Time: 13,65  
Transaction Rate: 5,339  

**Tiempo de respuesta:** Este algoritmo no se puede implementar en Nginx porque no se puede utilizar el tiempo de respuesta sólo, se utiliza teniéndolo en cuenta junto con el menor número de conexiones, que es el siguiente algoritmo.  

**Combinación del tiempo de respuesta y el menor número de conexiones:** Este algoritmo se puede implementar fácilmente con la directiva least_time, en la que podemos elegir entre escoger el tiempo que tarda en enviar la cabecera http (header) o lo que tarda en enviar todo el contenido (last_byte), pero es necesario tener Nginx Plus.  
La configuración es la siguiente:  

![(combinacion)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(combinacion)nginx.png)  

Y los resultados (en media) han sido:  
Availability: 97,98 %  
Longest Transaction: 25,93  
Response Time: 12,13  
Transaction Rate: 5,901  

###Más algoritmos en Nginx  

Por supuesto, esto es sólo una parte de lo que Nginx permite hacer. Vamos a ver ahora algunas otras opciones que pueden usarse para balancear la carga (y a su vez estas pueden combinarse entre sí y con las anteriores para crear algoritmos nuevos):  

**Ponderación con la directiva slow_start:** Supongamos que uno de los servidores se cae o se sobrecarga. La directiva `slow_start` permite dar un número de segundos en los cuales la carga irá creciendo, una vez vuelva a estar disponible el servidor, hasta llegar a la ponderación que realmente tiene. De esta forma, un servidor que ha estado caído empezará recibiendo carga más despacio que los demás.  
Para marcar un servidor como caído utilizamos lo mismo que anteriormente, las directivas `max_fails` y `fail_timeout` de forma que se marcará como caído si no sirve 3 peticiones en 5 segundos.  
La configuración es la siguiente:  

![(slow_start)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(slow_start)nginx.png)  

Los resultados (en media) han sido los siguientes:  
Availability: 82,06 %  
Longest Transaction: 27,56  
Response Time: 9,188  
Transaction Rate: 4,344  

Como vemos, se mejoran todos los datos con respecto al algoritmo de ponderación simple.  

**Basado en la IP**: La directiva `ip_hash` permite balancear en base la IP de cada usuario, de forma que las peticiones de un mismo usuario irán siempre al mismo servidor (a no ser que éste se caiga, en cuyo caso se mandaría a otro servidor), manteniendo así la persistencia de sesión.  
La configuración es la siguiente:  

![(ip_hash)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(ip_hash)nginx.png)  

Y los resultados (en media) han sido los siguientes:  
Availability: 79,21 %  
Longest Transaction: 28,91  
Response Time: 10,11  
Transaction Rate: 4,100  

**Balanceo con caché**: La directiva `keepalive` permite guardar en la caché de los servidores un número máximo de conexiones inactivas de forma que no se vuelva a abrir la conexión si una de estas IPs guardadas hace una nueva petición. Si este número es excedido, la conexión que lleva más tiempo inactiva se elimina y se introduce en su lugar una nueva.  
La configuración es la siguiente:  

![(keepalive)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(keepalive)nginx.png)  

Y los resultados (en media) son los siguientes:  
Availability: 85,18 %  
Longest Transaction: 29,85  
Response Time: 10,36  
Transaction Rate: 4,514  

Donde vemos que la disponibilidad es mejor con respecto al algoritmo anterior.  

**Balanceo con cola de peticiones**: Si un servidor alcanza el número máximo de conexiones, en lugar de mandar un mensaje de error directamente, la directiva `queue` permite meter en la cola (hay una cola común para todos los servidores) las peticiones que excedan ese máximo. Dicha directiva permite especificar el número máximo de peticiones que mantendremos en la cola (en este caso hemos puesto 30) y el tiempo que mantendremos dichas conexiones (por defecto es 60, pero lo hemos puesto para ilustrarlo).
La configuración es la siguiente:  

![(queue)nginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(queue)nginx.png)  

Los resultados han sido los siguientes:  
Availability: 97,74%  
Longest Transaction: 28,19  
Response Time: 12,63  
Transaction Rate: 5,625  

Como comprobamos, es un algoritmo que va bastante bien en este caso.  


Implementación y resultados de los algoritmos en HaProxy  
=============================
**Round Robin**: Es el algoritmo por defecto si no se especifica nada más, aunque se puede poner `balance roundrobin`, por lo que sólo tendremos que especificar las IPs de nuestras 4 máquinas en la sección backend servers. En concreto, el fichero de configuración localizado en `/etc/haproxy/haproxy.cfg` es:  

![(roundrobin)haproyx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(roundrobin)haproyx.png)  

Y los resultados (en media) han sido:  
Availability: 65,87 %  
Longest Transaction: 25,86  
Response Time: 6,959  
Transaction Rate: 3,143  

Basado en el menor número de conexiones: Este algoritmo está implementado sólo poniendo la directiva `leastconn`, pero ocurre como en Nginx, y es una versión mejorada del mismo, de forma que tampoco sobrecarga las máquinas si no tienen las mismas capacidades.  
La configuración es la siguiente:  

![(leastconn)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(leastconn)haproxy.png)  


Y los resultados (en media) han sido:   
Availability: 93,61 %  
Longest Transaction: 27,38  
Response Time: 10,87  
Transaction Rate: 5,693  

**Ponderación**: Es el round robin con pesos y se puede implementar igual utilizando la directiva `weight`.
La configuración es la siguiente (hemos dado los pesos en función de las capacidades de las máquinas):

![(ponderacion)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(ponderacion)haproxy.png)  

Y los resultados (en media) han sido:  
Availability: 76,25 %  
Longest Transaction: 28,13  
Response Time: 7,836  
Transaction Rate: 4,152  

**Prioridad**: Este algoritmo tampoco hemos podido aplicarlo tal y como está explicado en la primera sección. Sin embargo, hemos podido hacer dos formas distintas que se parecen al de prioridad, que son las siguientes:  
Prioridad A: utilizando el algoritmo `first`que incorpora HaProxy, que manda la petición al primer servidor que tenga conexiones disponibles. Los servidores se eligen en base al menor id, que si no se especifica, por defecto es el orden en el que están dadas las máquinas. Cada máquina tiene un número máximo de conexiones y una vez las alcanza, pasa a la siguiente máquina. La diferencia de este y el de prioridad inicial es que no se pueden hacer grupos de servidores. La configuración es la siguiente:  

![(prioridad)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(prioridad)haproxy.png)  

Y los resultados (en media) han sido los siguientes:  
Availability: 91,03 %  
Longest Transaction: 22,63  
Response Time: 13,96  
Transaction Rate: 5,445  

**Prioridad B**: La segunda opción es definir dos conjuntos de servidores y dejar uno de ellos como backup, de forma que sólo se le enviará carga si el primer conjunto supera un cierto número de conexiones, que en nuestro caso hemos configurado en 60. La configuración es la siguiente:  

![(prioridadB)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(prioridadB)haproxy.png)  

Y los resultados (en media) han sido los siguientes:  
Availability: 79,055 %  
Longest Transaction: 26,046  
Response Time: 8,554  
Transaction Rate: 4,273  


**Tiempo de respuesta**: Este algoritmo está siempre realmente implementado en HaProxy ya que para llevar a cabo el balanceo es necesario especificar la directiva `timeout server`, por lo que en realidad todos los algoritmos son una combinación de este con los demás.  

###Más algoritmos  

**Source**: Este algoritmo conduce a cada máquina siempre al mismo servidor a no ser que éste esté caído. El reparto inicial se hace según los pesos asignados y usando como función de asignación un hash de la IP.

![(source)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(source)haproxy.png)  

**Prioridad C**: Este algoritmo es similar a los explicados sobre prioridad aunque atiende a otros parámetros para escoger un grupo de servidores u otro. Entendiendo que el grupo por defecto es más potente por las características de sus servidores, usaremos el otro grupo de servidores en caso de que el ratio de llegada sea de más de 4 peticiones por segundo o bien al grupo por defecto le queden menos de 10 slots disponibles para recibir peticiones.  


![(prioridadC)haproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/(prioridadC)haproxy.png)  


Y los datos (en media) han sido:  
Availability: 72,70 %  
Longest Transaction: 24,16  
Response Time: 6,184  
Transaction Rate: 4,128  

###Representación de los datos:  
Vamos ahora a representar los datos obtenidos tanto en Nginx como en HaProxy.  

Representación de los datos de Nginx:  

![datosNginx](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/datosNginx.png)  

Donde la disponibilidad está con respecto al eje de la izquierda y los tiempos en el eje de la derecha. Vemos como los mejores algoritmos en este caso teniendo en cuenta la disponibilidad son el de menor número de conexiones, prioridad y la combinación de tiempo de respuesta y menor número de conexiones.  
En cuanto al algoritmo de ponderación y el algoritmo de ponderación con `slow_start`, como hemos dicho anteriormente, tenemos que al ponerle la directiva los tiempos y la disponibilidad mejoran un poco:  

![datosNginx2](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/datosNginx2.png) 

Comparamos ahora los nuevos algoritmos probados:  

![datosNginx3](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/datosNginx3.png)  

y vemos que sin duda el mejor de ellos es el que implementa la cola en la que se guardan las peticiones de no poder servirlas.  

Representación de los datos de HaProxy:  

![datosHaproxy](https://github.com/JacintoCC/swap1415/blob/master/Trabajo/img/datosHaproxy.png) 

Donde la disponibilidad está con respecto al eje izquierdo y los tiempos con respecto al eje derecho. Vemos que en este caso los mejores algoritmos son el de menor número de conexiones seguido del de prioridad A.  

###Referencia para Nginx:  
http://nginx.org/en/docs/http/load_balancing.html  

###Referencia para HaProxy:  
http://cbonte.github.io/haproxy-dconv/configuration-1.5.html  


