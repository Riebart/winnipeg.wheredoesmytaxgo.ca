#!/bin/bash

addr="$1"

page=$(wget -qO- https://www.winnipeg.ca/cao/pdfs/CommunityTrendsandPerformanceReportVolume1_2019.pdf | pdftotext -f 202 -l 202 -layout - -)
budgets=$(echo "$page" | tail -n +$[`echo "$page" | grep -n "Per Year *Per Month *% of Total" | cut -d':' -f1`+1] | head -n$[`echo "$page" | grep -n "City Property Tax Bill for Average House" | cut -d ':' -f1 | head -n1`-`echo "$page" | grep -n "Per Year *Per Month *% of Total" | cut -d':' -f1`-1] | perl -pe 's/^ *(.*?(?=  )) *\$*([.0-9]+) *\$*([.0-9]+) *\$*([.0-9]+)%* *$/\1;\2;\3;\4/')
taxes_data=$(wget -qO- 'http://www.winnipegassessment.com/Asmttax/pdfs/rates/2019CombinedMillRates.pdf' | pdftotext -layout - - | grep -oEm3 "(Property Class Code|Portioned Percentage|Municipal Mill Rate).*$" | sed 's/   */;/g')
tax_factor=$(echo "$taxes_data" | cut -d';' -f`echo "$taxes_data" | head -n1 | tr ';' '\n' | grep -n "Single-Family" | cut -d':' -f1` | tail -n2 | sed 's/\([0-9]*\)%/0.0\1/' | paste -sd '*' | bc)
assessed_value=$(wget -qO- "https://data.winnipeg.ca/resource/d4mq-wa44.json?\$where=full_address like '`echo "$addr" | tr 'a-z' 'A-Z'`%25'" | jq -r .[0].total_assessed_value)
tax_amount=$(echo "$tax_factor*$assessed_value/100" | bc)
echo "$budgets" | tr ' ;' '_ ' | while read dept budget avg_amt pct; do echo "\"$dept\":`echo $pct*$tax_amount/100 | bc`"; done | paste -sd ',' | sed 's/^/{/;s/$/}/' | jq .
