#!/bin/sh
# Logstash-Forwarder Installer

SERVER=

if [ ! $SERVER ]
then
  echo "Error: SERVER must be set"
  exit 2
fi

echo "Downloading Logstash-Forwarder and Keys"
wget http://$SERVER/s3/logstash/logstash-forwarder-0.3.1-1.x86_64.rpm -O /opt/logstash-forwarder-0.3.1-1.x86_64.rpm
wget http://$SERVER/s3/logstash/logstash-forwarder.conf -O /etc/logstash-forwarder.conf
wget http://$SERVER/s3/logstash/logstash-forwarder.crt -O /etc/pki/tls/certs/logstash-forwarder.crt
wget http://$SERVER/s3/logstash/logstash-forwarder.key -O /etc/pki/tls/private/logstash-forwarder.key

echo "Installing Logstash-Forwarder"
rpm -ivh /opt/logstash-forwarder-0.3.1-1.x86_64.rpm

echo "Starting Logstash-Forwarder"
nohup /opt/logstash-forwarder/bin/logstash-forwarder -config /etc/logstash-forwarder.conf > /dev/null &
