#!/bin/sh

whatis -r "${1:-"."}" | shuf -n 1
