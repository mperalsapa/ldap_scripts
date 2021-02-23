#!/bin/bash
if [ -z "$1" ]
then
        echo "falta fitxer d'introduccio de usuaris, exemple 'crear_grups_linux.sh llista_grups.txt"
else
        echo "---- Fitxer de grups -----"
        echo "$1"
        echo "--------------------------"
        for l in $(cat $1)
        do
                sudo sudo groupadd $l
        done
fi
