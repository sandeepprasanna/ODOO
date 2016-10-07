#!/bin/sh
echo $LD_LIBRARY_PATH | egrep "/home/administrator/second3/common" > /dev/null
if [ $? -ne 0 ] ; then
PATH="/home/administrator/second3/apps/odoo/bin:/home/administrator/second3/python/bin:/home/administrator/second3/postgresql/bin:/home/administrator/second3/apache2/bin:/home/administrator/second3/common/bin:$PATH"
export PATH
LD_LIBRARY_PATH="/home/administrator/second3/python/lib:/home/administrator/second3/postgresql/lib:/home/administrator/second3/apache2/lib:/home/administrator/second3/common/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH
fi

TERMINFO=/home/administrator/second3/common/share/terminfo
export TERMINFO
##### POSTGRES ENV #####

        ##### APACHE ENV #####

##### CURL ENV #####
CURL_CA_BUNDLE=/home/administrator/second3/common/openssl/certs/curl-ca-bundle.crt
export CURL_CA_BUNDLE
##### SSL ENV #####
SSL_CERT_FILE=/home/administrator/second3/common/openssl/certs/curl-ca-bundle.crt
export SSL_CERT_FILE
OPENSSL_CONF=/home/administrator/second3/common/openssl/openssl.cnf
export OPENSSL_CONF
OPENSSL_ENGINES=/home/administrator/second3/common/lib/engines
export OPENSSL_ENGINES


. /home/administrator/second3/scripts/build-setenv.sh
PYTHON_EGG_CACHE=/home/administrator/second3/.tmp
export PYTHON_EGG_CACHE
PYTHONPATH=/home/administrator/second3/apps/odoo/lib::$PYTHONPATH
export PYTHONPATH
PYTHONHOME=/home/administrator/second3/python
export PYTHONHOME

export LD_PRELOAD=libssl.so
