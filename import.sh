#!/bin/bash
passwordtls='PASSWORD'
for host in $(cat hosts)
do
    name=$(echo $host|cut -d'.' -f1)
    echo $name
    ls -l CRT/$name.cer
    keytool -importcert -alias rootca -keystore out/$host/$host.jks -file CRT/RootPKI.cer -keypass $passwordtls -storepass $passwordtls -noprompt
    keytool -importcert -alias subca -keystore out/$host/$host.jks -file CRT/SUB3PKI.cer -keypass $passwordtls -storepass $passwordtls -noprompt
    keytool -importcert -alias $host -file CRT/$name.cer -keystore out/$host/$host.jks  -keypass $passwordtls -storepass $passwordtls -noprompt
    keytool -importkeystore -srckeystore out/$host/$host.jks -destkeystore out/$host/$host.p12  -deststoretype PKCS12 -srcalias $host -deststorepass $passwordtls  -destkeypass $passwordtls  -srckeypass $passwordtls -srcstorepass $passwordtls
    openssl pkcs12 -in out/$host/$host.p12 -passout pass:$passwordtls  -nocerts -out out/$host/$host-pro.key -passin pass:$passwordtls

done