#!/bin/bash

stop()
{
    break
}

trap stop SIGINT

while true; do
    echo "y"
done