Ejercicios Tema 4 
=================  

T4.1
----
**Buscar información sobre cuánto costaría en la actualidad un mainframe. Comparar precio y potencia entre esa máquina y una granja web de unas prestaciones similares.**  
El último mainframe lanzado por IBM es el z13, orientado al manejo de datos y compras realizadas con el móvil. Como es habitual
 no se conoce el precio del mainframe, pero se estima que supere los 100.000$. El desembolso inicial sería mayor que el necesario
 para una granja web, aunque el gasto en electricidad y el espacio ocupado será menor. Por contra, es más difícilmente escalable
 y un fallo en la máquina nos dejaría sin poder servir a los clientes.  

T4.2  
----  
**Buscar información sobre precio y características de balanceadores hardware específicos. Compara las prestaciones
 que ofrecen unos y otros**  
Compararemos los modelos KEMP LM-5400 (17990$), F5 Networks LTM-2000s (17995$) y Citrix MPX-8005 (25000$).  
Max Throughput (GBs): 			10.02		5		5  	
Número de fuentes de alimentación: 	2		1		1  
Consumo (W): 				184.5		74		185  

T4.3
----
**Buscar información sobre los métodos de balanceo que implementan los dispositivos recogidos en el ejercicio 4.2**  
El modelo de KEMP LM-5400 implementa los algoritmos de Round Robin, Round Robin con pesos, el menor número de conexiones,
 menor número de conexiones con pesos, reparto mediante un sistema agente que estudia la carga del servidor, source o ip-hash
 (una petición de una máquina anteriormente servida va al mismo servidor), switching según el contenido de la capa 6 y usar
 un servidor por defecto y usar otro cuando haya mucha demanda.


