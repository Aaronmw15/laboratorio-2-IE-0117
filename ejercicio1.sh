 #!bin/bash
if whoami| grep -q "root" ; then #verificamos que el usuario sea root
    echo "-el usuario es root"
else                                     #si no es root, salimos del programa 
    echo "-el usuario no es root"
    exit
fi

#pedimos parametros (punto 2)
read -p "-por favor ingrese el nombre del usuario: " usuario
read -p "-por favor ingrese el nombre del grupo: " grupo
read -p "-por favor ingrese la ruta de archivo: " archivo

#verificamos que la ruta exista
if [ -f "$archivo" ]; then
    echo "-se ha encontrado la ruta"
else
    echo "-no se ha encontrado la ruta"
    exit
fi

#verificamos que el grupo existe
if getent group "$grupo" ; then
    echo "-el usuario solicitado ya existe"
else 
    groupadd $grupo #si el grupo no existe, lo creamos
    echo "-se ha creado el grupo" $grupo
fi

if grep -q "$usuario" /etc/passwd; then #vemos si el usuario se encuentra registrado
    echo "añadiendo a " $usuario "a" $grupo
    usermod -g $grupo $usuario #si es así, lo añadimos al grupo
else                           #si no, se crea el usuario y se añade al grupo
    echo "se ha creado el usuario" $usuario
    useradd $usuario
    echo "añadiendo a " $usuaario "a" $grupo
    usermod -g $grupo $usuario
fi

# el archivo pertenece al usuario y al grupo designado
echo "-se el archivo ahora pertenece a " $usuario
chown $usuario $archivo 
echo "-el archivo ahora pertenece al grupo" $grupo
chgrp $grupo $archivo  

chmod 740 $archivo
echo "se han modificado los permisos del archivo"