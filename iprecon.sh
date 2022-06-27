#!/bin/bash
#iprecon


shodan search "ssl:.target.com  200" --fields ip_str | tee IPs.txt 
python3 com.py
rustscan -a IPs.txt -r 1-65535 | grep Open | tee open_ports.txt 
cat open_ports.txt | sed 's/Open //' | httpx -silent | nuclei -t ~/nuclei-templates/
