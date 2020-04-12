#!/bin/sh
set -x
set -e
mkdir -p $TASKDDATA
taskd init
sed -i "s/CN=localhost/CN=$HOSTNAME/g" pki/vars
cd pki
./generate
./generate.client
cp client.cert.pem $TASKDDATA
cp client.key.pem  $TASKDDATA
cp server.cert.pem $TASKDDATA
cp server.key.pem  $TASKDDATA
cp server.crl.pem  $TASKDDATA
cp ca.cert.pem     $TASKDDATA
taskd config --force client.cert $TASKDDATA/client.cert.pem
taskd config --force client.key $TASKDDATA/client.key.pem
taskd config --force server.cert $TASKDDATA/server.cert.pem
taskd config --force server.key $TASKDDATA/server.key.pem
taskd config --force server.crl $TASKDDATA/server.crl.pem
taskd config --force ca.cert $TASKDDATA/ca.cert.pem
taskd config --force log $TASKDATA/taskd.log
taskd config --force pid.file taskd.pid
taskd config --force server 0.0.0.0:53589

