#!/bin/bash
### DEMO SOME AWK FOO

inFileName="../inFiles/awkTest01.txt"

echo -e "\n Dumping ${inFileName}"
awk '{print $0}' ./inFiles/awkTest01.txt


echo -e
echo -e 'R01C01 R01C02 R01C03 R01C04\nR02C01 R02C02 R02C03 R02C04' | awk '{print $(NF-1), '\t', $NF }'




echo -e
awk 'BEGIN { RS = " " } { print $(NF-1), '\t', $NF }' ./inFiles/awkTest03.txt
