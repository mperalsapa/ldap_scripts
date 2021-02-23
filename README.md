# ldap_scripts
## Crear usuaris a linux
Des d'una llista podem crear usuaris automaticament per despres fer-los servir amb els scripts d'LDAP.

```crear_usuaris_linux.sh /path/llista/usuaris.txt```

El fitxer ha de contenir nomes noms d'usuaris, per exemple <br>
```
agonzalez
psuarez
jhernandez
```

## Crear grups a linux
Des d'una llista podem crear grups per despres fer-los servir amb els scripts d'LDAP.

```crear_grups_linux.sh /path/llista/grups.txt```

El fitxer ha de contenir noms de grups, per exemple <br>
```
Alumnes
Professors
Direccio
```

## Crear usuaris a LDAP
Com el de crear a linux, aquest script necessita una llista d'usuaris. Demana nom i cognom a l'hora d'introduir cada usuari.<br>
Tambe demana un grup al que pertanyen. Per exemple, una llista d'alumnes pertany al grup "alumnes" de linux, no de LDAP.<br>
```
crear_usuaris_ldap.sh /path/llista/usuaris.txt "grup de linux al que pertanyen"
```
Amb la execucio ens demana el path de LDAP on crear els usuaris.

```
Introdueix la unitat organitzativa, per exemple ou=Alumnes,dc=domini,dc=com
dn:
```
I finalment ens dona un exemple de comanda per fer servir
```
S'ha generat el fitxer alumnes.ldif
El pots executar amb: ldapadd -x -W -D 'cn=admin,dc=domini,dc=com' -f alumnes.ldif
```

## Crear grups LDAP
Agafant d'una llita de grups genera un fitxer amb el gid d'aquestos per afegirlos a LDAP
```
crear_grups_ldap.sh /path/llista/grups.txt
```
Aquest script respon amb una comanda d'exemple
```
S'ha generat el fitxer grups.ldif
El pots executar amb: ldapadd -x -W -D 'cn=admin,dc=domini,dc=com' -f grups.ldif
```

## Afegir usuaris LDAP a grup LDAP
Aquest script afegeix els usuaris d'una llista a un grup LDAP. Els usuaris que hi ha a la llista han de ser usuaris LDAP.
```afegir_usuaris_a_grup_ldap.sh /path/llista/usuaris.txt```
Introduim un path del objecte grup dintre del LDAP
```
introdueix dn del grup, per exemple dn:cn=comptables,ou=grups,dc=domini,dc=com
grup ldap dn:
```
I ens respon amb la generacio del fitxer i un exemple de comanda
```
S'ha generat el fitxer grups.ldif
El pots executar amb: ldapmodify -x -W -D 'cn=admin,dc=domini,dc=com' -f grups.ldif
```

## Crear Unitats Organitzatives
Aquest script genera el fitxer necessari per crear UO. Simplement ens demana el path que volem per la nova UO, i el nom d'aquesta
```afegir_uo_ldap.sh```
```
Recorda: Es generara un fitxer amb el nom unitats.ldif
El podrás executar amb sudo ldapadd -x -D cn=admin,dc=domini,dc=com -W -f unitats.ldif
```
Ens demanara nom de la UO i la ruta.

```
Nom de la Unitat Organitzativa :
Ruta de la UO [uo=grups,dc=dom,dc=com]:
```
Introduides les anteriors dades ens indica que si volem sortir premem ctrl+c ja que et permet crear mes d'una uo a la vegada.
```
per sortir del programa prem ctrl+c, les dades introduides s'han guardat.
```

# Comandes utils LDAP
## Afegir UO
sudo ldapadd -x -D cn=admin,dc=domini,dc=com -W -f fitxer.ldif

## Afegir usuari
sudo ldapadd -x -W -D "cn=admin,dc=domini,dc=com" -f fitxer_usuari.ldif

## Modificar contrassenya
sudo ldappasswd -s Passw0rd -W -D "cn=admin,dc=domini,dc=com" -x "uid=usuari,ou=usuaris,dc=domini,dc=com"

## Afegir grup
sudo ldapadd -x -W -D "cn=admin,dc=domini,dc=com" -f fitxer_grups.ldif

## Afegir usuaris a grups
sudo ldapmodify -x -W -D "cn=admin,dc=domini,dc=com" -f fitxer.ldif

## Mostrar usuaris en ldap
sudo ldapsearch -x -LLL -b dc=domini,dc=com 'uid=*' | grep "dn: uid="
