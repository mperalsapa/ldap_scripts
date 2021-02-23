#!/bin/bash
if [ -z "$1" ]
then
        echo "falta fitxer d'introduccio de usuaris, exemple 'script.sh llista_usuaris.txt"
else
        echo "---- Fitxer d'usuaris ----"
        echo "$1"
        echo "--------------------------"
        read -p "Introdueix una contrasenya pels usuaris:" passwd
        for l in $(cat $1)
        do
                sudo useradd -p $passwd $l
        done
fi
