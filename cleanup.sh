#!/bin/sh

application=$1

if [ -z "$application" ]; then
  application="image-runner"
fi
oc delete all --selector="application=${application}"
oc delete "cm/${application}"
oc replace "template/${application}" -f template.json
