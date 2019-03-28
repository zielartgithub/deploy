#!/bin/bash
while ! `curl -s http://ec2-18-185-117-59.eu-central-1.compute.amazonaws.com:8082/status | grep -q '"status": "ok"'`; do echo "${PIPESTATUS[0]}" && sleep 10; done;
        exit 0