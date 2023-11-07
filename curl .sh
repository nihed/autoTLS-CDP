#!/bin/bash
for host in $(cat hosts)
do
        name=$(echo $host|cut -d'.' -f1)
        echo '{'
        echo "\"hostname\" : \"$host\","
        echo "\"certificate\" : \"/tmp/tls/$name.cer\","
        echo "\"key\" : \"/tmp/tls/$host.key\""
        echo '},'
done