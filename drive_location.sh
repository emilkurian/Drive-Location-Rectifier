#!/bin/bash

##### Expander and Drive List

EXPANDER="$(lsscsi -g | grep encl | awk '{print $4" "7}')"
DRIVES="$(lsscsi -tg | grep sd | awk '{print $3" "$4}')"


##### Drive Logic

header="\n %-10s %8s %10s\n"


printf "$header" "DRIVE" "SLOT" "EXPANDER" 

file1 = $EXPANDER
while IFS=" " read -r b1 b2
do 
    file2=$DRIVES
    while IFS=" " read -r f1 f2
    do 
        SASADDR = ${f1:6}
        if grep -q >>> ${sg_ses --sas_addr="$SASADDR" "$b2"}; then
            :
        else:
            SLOT=${sg_ses --sas_addr="$SASADDR" "$b2" | grep Slot | awk '{print $1}'}
            printf "$header" "$f2" "$SLOT" "$B1" 
        
    done <"$file2"


done <"$file1"

exit 0 
