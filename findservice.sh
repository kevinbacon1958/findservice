#!/bin/bash
whois -h whois.ripe.net -T route ${1} -i origin | egrep "route: " | awk '{print $NF}' | tee ip-ranges.txt
sed "s/$/:$2/" ip-ranges.txt | tee ip-ranges-with-port.txt
cat ip-ranges-with-port.txt | xargs -n1 unicornscan | tee ip-lists.txt
cat ip-lists.txt | grep from | awk '{print $6}' | tee formatted_ips.txt
rm ip-ranges.txt
rm ip-ranges-with-port.txt
rm ip-lists.txt
nmap -iL formatted_ips.txt -p $2 | tee results.txt
