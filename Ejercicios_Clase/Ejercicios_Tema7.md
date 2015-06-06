Ejercicios Tema 7  
=================  

T7.1  
----  
**¿Qué tamaño de unidad de unidad RAID se obtendrá al configurar un RAID 0 a partir de dos discos de 100 GB y 100 GB?**  
El tamaño de unidad del RAID será de 200GB pues simplemente se reparte la información entre todo el espacio disponible.  
**¿Qué tamaño de unidad de unidad RAID se obtendrá al configurar un RAID 0 a partir de tres discos de 200 GB cada uno?**  
El tamaño de unidad del RAID será de 3*200GB=600GB pues se reparte la información entre todo el espacio disponible.  

T7.2  
----  
**¿Qué tamaño de unidad de unidad RAID se obtendrá al configurar un RAID 1 a partir de dos discos de 100 GB y 100 GB?**  
El tamaño de unidad del RAID será de 100GB pues se replica la información en los dos discos.  
**¿Qué tamaño de unidad de unidad RAID se obtendrá al configurar un RAID 1 a partir de tres discos de 200 GB cada uno?**  
El tamaño de unidad del RAID será de 200GB pues se replica la información en los tres discos.  

T7.3  
----  
**¿Qué tamaño de unidad de unidad RAID se obtendrá al configurar un RAID 5 a partir de tres discos de 120 GB cada uno?**  
El tamaño de unidad del RAID será de 240GB pues se usa el espacio correspondiente a uno de los discos (repartido entre los tres) para almacenar la paridad.  

T7.4  
----  
**Buscar información sobre los sistemas de ficheros en red más utilizados en la actualidad y comparar sus características. Hacer una lista de ventajas e inconvenientes de todos ellos, así como grandes sistemas en los que se utilicen.**  
Los sistemas de ficheros en red más utilizados son NFS, el programa Samba y Server Message Block. Destacando ampliamente NFS.  
NFS está dividido en dos partes, servidor y clientes. Los clientes acceden de manera remota a los sdatos almacenados en el servidor. De esta manera las estaciones de trabajo locales utilizan menos espacio de disco, pues los datos se encuentran centralizados, aunque pueden ser accedidos y modificados por varios usuarios. También se puede acceder a través de la red a dispositivos de almacenamiento como disqueteras o lectores CD-ROM.  
Server Message Block (SMB) es un protocolo de red que permite compartir archivos e impresoras entre nodos de una red usado principalmente en ordenadores con Windows y DOS. Fue originalmente inventado por IBM aunque la versión más utilizada hoy en día es la modificada por Microsoft, llamada CIFS e incluye soporte para enlaces simbólicos, enlaces duros y mayores tamaños de archivo.
Samba es una implementación libre del protocolo de archivos compartidos de Windows para sistemas Unix. Está basado en Server Message Block (De hecho su nombre surge al añadirle dos vocales a SMB). Funciona configurando directorios Unix como recursos para compartir a través de la red. Éstos aparecen como carpetas de red para los usuarios de Windows. Se permite dar distintos permisos según el usuario.
