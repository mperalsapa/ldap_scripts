#!/bin/bash
read -p "Nom del fitxer resultant [fitxer.ldif]:" nomfitxer
touch "$nomfitxer"
echo "">"$nomfitxer"
echo "Recorda: Es generara un fitxer amb el nom $nomfitxer"
echo "El podrás executar amb sudo ldapadd -x -D cn=admin,dc=domini,dc=com -W -f $nomfitxer"

while true;
do
        read -p "Nom de la Unitat Organitzativa :" nomUo
        read -p "Ruta de la UnitatOrganitzativa [ou=patata,dc=dom,dc=com]:" rutaUo
        echo "dn: $rutaUo" >> $nomfitxer
        echo "objectClass: organizationalUnit" >> $nomfitxer
        echo "ou: $nomUo" >> $nomfitxer
        echo "" >> $nomfitxer
        echo "per sortir del programa prem ctrl+c, les dades introduides s'han guardat."
done
