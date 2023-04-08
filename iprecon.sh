#!/bin/bash

by="\e[96m"
bye="\e[96;00m"
rl="\033[31m"
rle="\033[00m"
br="\033[1;31m"
bre="\033[1;00m"
blink="\e[5m"

printf ""$by"

'####:'########::'########::'########::'######:::'#######::'##::: ##:
. ##:: ##.... ##: ##.... ##: ##.....::'##... ##:'##.... ##: ###:: ##:
: ##:: ##:::: ##: ##:::: ##: ##::::::: ##:::..:: ##:::: ##: ####: ##:
: ##:: ########:: ########:: ######::: ##::::::: ##:::: ##: ## ## ##:
: ##:: ##.....::: ##.. ##::: ##...:::: ##::::::: ##:::: ##: ##. ####:
: ##:: ##:::::::: ##::. ##:: ##::::::: ##::: ##: ##:::: ##: ##:. ###:
'####: ##:::::::: ##:::. ##: ########:. ######::. #######:: ##::. ##:
....::..:::::::::..:::::..::........:::......::::.......:::..::::..:: 
                                       
        V2.1.0
        Coded By Neh Patel with Love <3 ❤ 
                                                                         
                                                                                     
"$bye""


printf ""$rl"
Twitter :-   https://twitter.com/thecyberneh
Instagram :- https://www.instagram.com/thecyberneh/
Linkedin :-  https://www.linkedin.com/in/thecyberneh/
"$rle""

echo -e "\n"
echo -e "\n"

echo -e "$by"[INFO] Target: $1 "$bye"
echo -e "\n"
echo -e "$rl"[CRITICAL]"$rle" "$by"Configure shodan with your api key before running "$bye"
echo -e "\n"
echo -e "$by"[INFO] Starting scan for IPs "$bye"
shodan search "hostname:"$1"  200" --limit 1000 --fields ip_str | tee IPs.txt 
echo -e "\n"
echo -e "$by"[INFO] All IPs are saved in file: IPs.txt "$bye"
echo -e "\n"
cat IPs.txt | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tee forRust.txt
echo -e "\n"
echo -e "$by"[INFO] Scanning for open ports "$bye"
rustscan -a 'forRust.txt' -r 1-65535 --ulimit 5000 --scripts none | tee rustscanRes.txt
echo -e "\n"
cat rustscanRes.txt | grep Open | tee open_ports.txt 
echo -e "\n"
cat open_ports.txt | sed 's/Open //' | httpx -silent | tee IPUrls.txt
echo -e "\n"
nuclei -l IPUrls.txt -t /root/nuclei-templates/ | tee IPNucleiResults.txt
