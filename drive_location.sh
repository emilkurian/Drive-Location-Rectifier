#!/bin/bash

##### Drive Logic

header="\n %-8s %8s %12s\n"

lsscsi -g | grep encl | awk '{print $4" "$7}' > expanders.txt
lsscsi -tg | grep sd | awk '{print $3" "$4}' > drives.txt


printf "$header" "DRIVE" "SLOT" "EXPANDER" 

# Rectify Names to Drive slots/Expanders

cat expanders.txt | while IFS=" " read -r b1 b2
do 
    cat drives.txt | while IFS=" " read -r f1 f2
    do 

        SASADDR=${f1:6}
        if sg_ses --sas_addr="$SASADDR" "$b2"| grep -q match; then
            :
        else
            SLOT="$(sg_ses --sas_addr="$SASADDR" "$b2" | grep Slot | awk '{print $1}')"
            printf "$header" "$f2" "$SLOT" "$b1" 
	fi        
    done

done

# Cleanup

rm expanders.txt
rm drives.txt

exit 0 

