#!/bin/bash
set -e
PATH_IN_DOCKER=/home/coq/.opam/4.13.1+flambda/bin:/home/coq/.local/bin:/home/coq/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
COQ_PREFIX=/home/coq/.opam/4.13.1+flambda/bin
docker pull coqorg/coq
docker rm fmcontainerbhvbedrock &> /dev/null || true
docker run --name fmcontainerbhvbedrock -d -ti coqorg/coq
docker exec fmcontainerbhvbedrock git clone https://github.com/Matafou/coq -b fix-prompt-err-17753

docker exec -w /home/coq/coq -e PATH=$PATH_IN_DOCKER fmcontainerbhvbedrock  ./configure -prefix=$COQ_PREFIX -no-ask

docker exec -w /home/coq/coq -e PATH=$PATH_IN_DOCKER fmcontainerbhvbedrock  make dunestrap

docker exec -w /home/coq/coq -e PATH=$PATH_IN_DOCKER fmcontainerbhvbedrock dune build -p coq-core,coq-stdlib,coq,coqide-server

docker exec -w /home/coq/coq -e PATH=$PATH_IN_DOCKER fmcontainerbhvbedrock dune install --prefix=$COQ_PREFIX coq-core coq-stdlib coq coqide-server

#docker exec fmcontainerbhvbedrock sudo apt update
#docker exec fmcontainerbhvbedrock sudo apt -y install expect
#docker stop fmcontainerbhvbedrock
#docker commit fmcontainerbhvbedrock coqunbuffer
#docker rm fmcontainerbhvbedrock
