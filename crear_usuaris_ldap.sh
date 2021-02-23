#!/bin/bash
if [ -z "$1" ]
then
        echo "falta fitxer d'introduccio de alumnes, exemple 'alumnes_ldap.sh fitxer_creacio'"
else
        if [ -z "$2" ]
        then
                echo "falta grup al que afegir usuaris"
        else
                read -p "Nom del fitxer resultant [fitxer.ldif]:" nomfitxer
                echo "$2"
                echo "---- Fitxer d'usuaris ----"
                echo "$1"
                echo "--------- Grup -----------"
                echo "nom $2"
                idGrup="$(cat /etc/group | grep $2 | cut -d: -f3)"
                echo "guid = $idGrup"
                echo "--------------------------"
                echo "">$nomfitxer
                echo "Introdueix la unitat organitzativa, per exemple ou=Alumnes,dc=domini,dc=com"
                read -p "dn:" uOrganitzativa
                for l in $(cat $1)
                do
                        echo "usuari $l"
                        read -p "Nom :" nomUsuari
                        read -p "Cognom :" cognUsuari
                        idUsuari="$(id -u $l)" >> $nomfitxer
                        echo "dn: uid=$l,$uOrganitzativa" >> $nomfitxer
                        echo "objectClass: inetOrgPerson" >> $nomfitxer
                        echo "objectClass: posixAccount" >> $nomfitxer
                        echo "objectClass: shadowAccount" >> $nomfitxer
                        echo "uid: $l" >> $nomfitxer
                        echo "sn: $cognUsuari" >> $nomfitxer
                        echo "givenName: $nomUsuari" >> $nomfitxer
                        echo "cn: $nomUsuari $cognUsuari" >> $nomfitxer
                        echo "displayName: $nomUsuari $cognUsuari" >> $nomfitxer
                        echo "uidNumber: $idUsuari" >> $nomfitxer
                        echo "gidNumber: $idGrup" >> $nomfitxer
                        echo "userPassword: $lpassword" >> $nomfitxer
                        echo "gecos: $nomUsuari $cognUsuari" >> $nomfitxer
                        echo "loginShell: /bin/bash" >> $nomfitxer
                        echo "homeDirectory: /home/$l" >> $nomfitxer
                        echo "" >> $nomfitxer

                done
                echo "S'ha generat el fitxer $nomfitxer"
                echo "El pots executar amb: ldapadd -x -W -D 'cn=admin,dc=domini,dc=com' -f $nomfitxer"
        fi
fi
