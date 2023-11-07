# autoTLS-CDP
For CDP, cloudera provide a set of automatic options to configure TLS. https://blog.cloudera.com/auto-tls-in-cloudera-data-platform-data-center/ 

For security reason, most of the custmer will ask to use certificates signed by internal company for each host. 

These scripts will help customer to automate the process of CSR generation, signing and population on CM. All these scripts need to run on CM node. 

## Generation generate.sh
This script will require a file hosts that will list all nodes where we are planning to enable TLS. 

The script will generate the jks but also the CSR that need to be communicated to the PKI Team

*  For safety reason, it's better to backup the output folder.


## Import import.sh
The PKE will communicate for you the chain but also the reply (that represent the public key). 

The script will be responsible to import the reply and the chain but also prepare the encrypted private key. 


## Populate populate.sh
I use this script to populate a temp folder that will be used by CM to do the tls Enablement during the curl command. 

## Curl curl.sh
If customer have a long list of nodes, this will help to prepare the list of host parts and have just to copy paste inside the body that will be used. 


` curl -i -v -uadmin:admin -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{`

`"location" : "/opt/cloudera/AutoTLS",`
`"customCA" : true,`

`"interpretAsFilenames" : true,`

`"cmHostCert" : "/tmp/auto-tls/certs/ccycloud-7.vcdp71.root.hwx.site.pem",`

`"cmHostKey" : "/tmp/auto-tls/keys/ccycloud-7.vcdp71.root.hwx.site-key.pem",`

`"caCert" : "/tmp/auto-tls/ca-certs/cfssl-chain-truststore.pem",`

`"keystorePasswd" : "/tmp/auto-tls/keys/key.pwd",`

`"truststorePasswd" : "/tmp/auto-tls/ca-certs/truststore.pwd",`

`"hostCerts" : [ `

**can be replaced by curl command result**

` ],`

`"configureAllServices" : "true",`

`"sshPort" : 22,`

`"userName" : "root",`

`"password" : "cloudera"`

`}' 'http://ccycloud-7.vcdp71.root.hwx.site:7180/api/v41/cm/commands/generateCmca' `

