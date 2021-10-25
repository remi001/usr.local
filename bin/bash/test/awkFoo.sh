#!/bin/bash
### DEMO SOME AWK FOO

inFileName="../inFiles/awkTest01.txt"

echo -e "\n Dumping ${inFileName}"
awk '{print $0}' ./inFiles/awkTest01.txt


echo -e
echo -e 'R1C1 R1C2 R1C3 R1C4\nR2C1 R2C2 R2C3 R2C4' | awk '{print $(NF-1), '\t', $NF }'




echo -e
awk 'BEGIN { RS = " " } { print $(NF-1), '\t', $NF }' ./inFiles/awkTest03.txt
