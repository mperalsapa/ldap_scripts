#!/bin/bash
if [ -z "$1" ]
then
        echo "falta fitxer d'introduccio de usuaris, exemple 'grups_ldap.sh fitxer_usuaris.txt'"
else
        read -p "Nom del fitxer resultant [fitxer.ldif]:" nomfitxer
        echo "---- Fitxer d'usuaris ----"
        echo "$1"
        echo "--------------------------"
        touch "$nomfitxer"
        echo "">"$nomfitxer"

        echo "introdueix dn del grup, per exemple dn:cn=comptables,ou=grups,dc=domini,dc=com"
        read -p "grup ldap dn:" grupLdap

        for l in $(cat $1)
        do
                echo "dn: $grupLdap" >> $nomfitxer
                echo "changetype: modify" >> $nomfitxer
                echo "add: memberuid" >> $nomfitxer
                echo "memberuid: $l" >> $nomfitxer
                echo "" >> $nomfitxer
        done
        echo "S'ha generat el fitxer $nomfitxer"
        echo "El pots executar amb: ldapmodify -x -W -D 'cn=admin,dc=domini,dc=com' -f $nomfitxer"
fi
