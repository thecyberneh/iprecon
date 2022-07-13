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
                                       
        V1.1.0
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
shodan search "ssl:.$1  200" --fields ip_str | tee IPs.txt 
echo -e "\n"
echo -e "$by"[INFO] All IPs are saved in file: IPs.txt "$bye"
echo -e "\n"

for i in `cat IPs.txt`;
do
        echo "$i""," >> forRust1.txt
done
cat forRust1.txt | sed '$s/,$//' | tee forRust.txt
echo -e "\n"
echo -e "$by"[INFO] Ready for rustscan with file: forRust.txt "$bye"
echo -e "\n"
rustscan -a forRust.txt -r 1-65535 | grep Open | tee open_ports.txt 
echo -e "$by"[INFO] Ready for nuclei with file: open_ports.txt "$bye"
cat open_ports.txt | sed 's/Open //' | httpx -silent | tee IPUrls.txt
nuclei -l IPUrls.txt -t /root/nuclei-templates/ | IPNucleiResults.txt
