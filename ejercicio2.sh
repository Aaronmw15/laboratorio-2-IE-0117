#!/bin/bash
#lo primero es ejecutar un proceso
"$@" &  #ejecutamos el comando que el usuario ingresó como argumento en segundo plano(background)
pid=$! #obtenemos el pid del ultimo proceso ejecutado
touch archivo.log #creamos un archivo log para registrar la información

while ps -p $pid > /dev/null; do #este bucle se detiene sólo hasta que el proceso finaliza

    # Obtener el uso de CPU y memoria del proceso
  info=$(ps -p $pid -o %cpu,%mem --no-headers) #creamos una variable que guarda las columnas de cpu y memoria, sin encabezdos para ser más ordenados
  hora=$(date +"%H:%M")

  echo "$hora, $info" >> archivo.log #creamos una nueva linea con la información en ese instante
  
done

echo "El proceso ha terminado."