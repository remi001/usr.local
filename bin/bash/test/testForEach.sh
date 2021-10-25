#! /bin/bash

#############################################################################
###
### Sometimes configuration is easier when you can
###     see the elements as they happen
###
### In this case if there are lots of email addresses to add
###    then an array can be used to load them
###
#############################################################################

set ECHO = false

#--
#-- Build the Logging DISTRIB_LIST
#--   Note: Only the person's eid is needed
#--
     recip[0]="developer_001"
     recip[1]="developer_001"

     i=0
     for email in ${recip[*]}; do
      
         if ( "${ECHO}" == "true" ) then
             print "\$i ........... [${i}]"
             print "\$email ....... [${email}]"
         fi

         if [ `expr ${i}` -eq 0 ]; then
             DISTRIB_LIST="${email}@company.com"
         else
             DISTRIB_LIST="${DISTRIB_LIST},${email}@company.com"
         fi
 
         i=`expr ${i} + 1`
     done
        
     export DISTRIB_LIST
     
     if ( "${ECHO}" == "true" ) then
         print "\$DISTRIB_LIST ... [${DISTRIB_LIST}]"
     fi
     
