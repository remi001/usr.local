#! /bin/bash

###
### LOAD PROPERTIES from this separate file
###
ENV=${1:-QA}
printf ". \n"
printf ". INFO: First Arg ..... [%s]\n" ${1}
printf ". INFO: Loading ENV ... [%s]\n" ${ENV}
printf ". \n"

if [[ $# -ne 1 ]]; then
   printf ". WARN: Loading the default environment of [%s]\n" ${ENV}
   printf ". INFO: To use a specific ENV use one of [QA|Prod] as the first argument.\n"
   printf ". \n"
   sleep 5
fi

do_load_props() {
  case ${ENV} in
    T|TST|TEST)
      printf ". INFO: Loading TEST environment [%s]\n" ${ENV}
      ### Either of the following command formats work
      #. ./env/test.properties
      source ./env/test.properties
      ;;
    Q|QA|PP)
      printf ". INFO: Loading QA/PP environment [%s]\n" ${ENV}
      source ./env/qa-east.properties
      ;;
    P|PR|Prod)
      printf ". INFO: Loading PROD/PR environment [%s]\n" ${ENV}
      source ./env/pr-east.properties
      ;;
    *)
      printf ". ERROR: Supply an ENV as one of [TEST|QA|Prod] as the first argument.\n"
      exit 1
      ;;
  esac
}

do_echo_setup() {
  echo -e "."
  echo -e ". DB_HOST .......... [${DB_HOST}]"
  echo -e ". DB_PORT .......... [${DB_PORT}]"
  echo -e "."
  echo -e ". BASTION_HOST ..... [${BASTION_HOST}]"
  echo -e ". BASTION_IP ....... [${BASTION_IP}]"
  echo -e ". BASTION_PORT ..... [${BASTION_PORT}]"
  echo -e "."
  echo -e ". BSTN_DGTK_EAST ... [${BSTN_DGTK_EAST}]"
  echo -e ". BSTN_DGTK_WEST ... [${BSTN_DGTK_WEST}]"
  echo -e "."
}

do_load_props
do_echo_setup
