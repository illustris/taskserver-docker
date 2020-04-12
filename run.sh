#!/bin/sh
set -x
set -e
test -f $TASKDDATA/config || /setup.sh
taskd server
