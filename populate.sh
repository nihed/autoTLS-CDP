#!/bin/bash
rm -rf /tmp/tls
mkdir /tmp/tls
passwordtls='PASSWORD'
passwordtrust='PASSWORDTRUST'
cat CRT/RootPKI.cer CRT/SUB3PKI.cer > CRT/ca.pem 
cp CRT/ca.pem /tmp/tls
echo $passwordtls > /tmp/tls/key.pwd
echo $passwordtrust > /tmp/tls/truststore.pwd

for host in $(cat hosts)
do
        name=$(echo $host|cut -d'.' -f1)
        echo $name
        cp out/$host/$host.key /tmp/tls
        cp CRT/$name.cer /tmp/tls
done

chown -R cloudera-scm /tmp/tls