#!/bin/sh

if [ $# -eq 0 ] || [ $# -eq 1 ]; then
  echo "Usage: get.sh [serviceaccount] [query]\n";
  exit 0;
fi

serviceaccount=$1
query=$2

# get server
server=`oc status|head -n 1|sed 's/.*\(http\)/\1/'`;
token_name=`oc get secrets|grep "$serviceaccount-token"|head -n 1|cut -d" " -f1`;
token=`oc describe secret/${token_name}|grep "^token"|sed 's/^token://'|tr -d '[:space:]'`;

#echo "server='${server}'";
#echo "token name='${token_name}'";
#echo "token='${token}'";
#echo "query='${query}'";

curl -X GET -H "Authorization: Bearer ${token}" "${server}${query}" --insecure
