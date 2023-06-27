#!/bin/bash
docker pull coqorg/coq
docker rm fmcontainerbhvbedrock
docker run --name fmcontainerbhvbedrock -d -ti coqorg/coq
docker exec fmcontainerbhvbedrock sudo apt update
docker exec fmcontainerbhvbedrock sudo apt -y install expect
docker stop fmcontainerbhvbedrock
docker commit fmcontainerbhvbedrock coqunbuffer
docker rm fmcontainerbhvbedrock
