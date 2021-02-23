#!/bin/bash
if [ -z "$1" ]
then
        echo "falta fitxer d'introduccio de grups, exemple 'creacio_grups_ldap.sh fitxer_grups.txt'"
else
        read -p "Nom del fitxer resultant [fitxer.ldif]:" nomfitxer
        echo "---- Fitxer de grups ----"
        echo "$1"
        echo "--------------------------"
        touch "$nomfitxer"
        echo "">"$nomfitxer"

        echo "introdueix dn de la UO, per exemple dn:ou=grups,dc=domini,dc=com"
        read -p "grup ldap dn:" dn

        for l in $(cat $1)
        do
            gid="$(cat /etc/group | grep $l | cut -d: -f3)"
            echo "dn : $dn" >> $nomfitxer
            echo "objectClass : top" >> $nomfitxer
            echo "objectClass: posixGroup" >> $nomfitxer
            echo "gidNumber: $gid" >> $nomfitxer
        done
        echo "S'ha generat el fitxer $nomfitxer"
        echo "El pots executar amb: ldapadd -x -W -D 'cn=admin,dc=domini,dc=com' -f $nomfitxer"
fi
