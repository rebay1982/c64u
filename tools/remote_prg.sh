#!/bin/bash

HOST=$1
PRG_FILE=$2

curl "http://$HOST/v1/runners:run_prg" \
	-XPOST \
	-H "Content-Type: application/octet-stream" \
	--data-binary "@$PRG_FILE" \
	
