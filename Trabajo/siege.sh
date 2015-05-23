#!/bin/bash

function mediaAritmetica() 
{   
   declare -a numeros=("${!1}")
   local media=0
   for item in ${numeros[@]}
   do
      media=`echo "scale=3; $media + $item" | bc -l`
   done
   media=`echo "scale=3; $media / ${#numeros[@]}" | bc -l`
   echo "$media"
}

PRUEBAS=10
declare -A URLS=( ["granja_haproxy_source"]="192.168.22.131/f.php" )


for destino in ${!URLS[@]}
do
   availability=()
   elapsedTime=()
   responseTime=()
   transactionRate=()
   longestTransaction=()
   salida=""
   echo -n "Probando con $peticiones peticiones en $destino..."

   for (( prueba=1; prueba<=$PRUEBAS; prueba++ ))
   do
		siege -b -t120s -c 80 -v 192.168.22.131/f.php 2> ../Datos/$destino-salidaerror.dat
      availability+=(`cat ../Datos/$destino-salidaerror.dat | egrep "Availability:" | tr -s ' ' | cut -d" " -f2`)
		elapsedTime+=(`cat ../Datos/$destino-salidaerror.dat | egrep "Elapsed time:" | tr -s ' ' | cut -d" " -f3`)
      responseTime+=(`cat ../Datos/$destino-salidaerror.dat | egrep "Response time:" | tr -s ' ' | cut -d" " -f3`)
      transactionRate+=(`cat ../Datos/$destino-salidaerror.dat | egrep "Transaction rate:" | tr -s ' ' | cut -d" " -f3`)
      longestTransaction+=(`cat ../Datos/$destino-salidaerror.dat | egrep "Longest transaction:" | tr -s ' ' | cut -d" " -f3`)
      echo $prueba
   done
   echo

   media_availability=`mediaAritmetica availability[@]`
   media_elapsedTime=`mediaAritmetica elapsedTime[@]`
   media_responseTime=`mediaAritmetica responseTime[@]`
   media_transactionRate=`mediaAritmetica transactionRate[@]`
   media_longestTransaction=`mediaAritmetica longestTransaction[@]`

   echo "$media_availability" >> ../Datos/$destino-media_availability.dat
   echo "$media_elapsedTime" >> ../Datos/$destino-media_elapsedTime.dat
   echo "$media_responseTime" >> ../Datos/$destino-media_responseTime.dat
   echo "$media_transactionRate" >> ../Datos/$destino-media_transactionRate.dat
   echo "$media_longestTransaction" >> ../Datos/$destino-media_longestTransaction.dat
done


      



