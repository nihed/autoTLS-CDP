#!/bin/bash
rm -rf out/*
company='OU=IT, O=CustomerName, L=Location, ST=State,C=CountryCode'
passwordtls='PASSWORD'
for host in $(cat hosts)
do
        echo "$host"
        mkdir out/$host
        keytool -genkeypair -alias $host -keyalg RSA -keystore out/$host/$host.jks -keysize 2048 -dname "CN=$host, $company" -ext san=dns:$host -keypass $passwordtls -storepass $passwordtls
        keytool -certreq -alias $host -keystore out/$host/$host.jks -file out/$host.csr -ext san=dns:$host -ext EKU=serverAuth,clientAuth -keypass $passwordtls -storepass $passwordtls
done