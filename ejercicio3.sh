#!/bin/bash



touch /home/aaron/Documentos/cambios.log #creamos un archivo que registra los cambios en el escritorio
cambios=/home/aaron/Documentos/cambios.log #creamos una variable para manipular el archivo
echo 'archivo de cambios creado'

#ahora usamos itnotifiwait para monitorear cambios de creacion, modificacion y eliminacion en el escritorio
inotifywait -m -e create -e modify -e delete /home/aaron/Escritorio | while read evento archivo #creamos un bucle que lee linea por linea, la salida de inotifiwait y la divide en dos columnas
do
    hora=$(date +"%Y-%m-%d %H:%M:%S") #guardamos la hora y fecha
    echo "$hora - Evento: $evento - Archivo: $archivo" >> "$cambios" # registramos todo en una linea nueva en el archivo
done

