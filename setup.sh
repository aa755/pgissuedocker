#!/bin/bash
set -x
set -e
COQ_PREFIX=$OPAM_SWITCH_PREFIX
docker pull coqorg/coq
docker stop fmcontainerbhvbedrock &> /dev/null || true
docker rm fmcontainerbhvbedrock &> /dev/null || true
docker run --name fmcontainerbhvbedrock -d -ti coqorg/coq
docker exec fmcontainerbhvbedrock git clone https://github.com/Matafou/coq -b fix-prompt-err-17753
COQ_PREFIX=`docker exec fmcontainerbhvbedrock /bin/bash -c "source ~/.profile && printenv" | grep OPAM_SWITCH_PREFIX | cut -d '='  -f 2`
docker exec -w /home/coq/coq fmcontainerbhvbedrock /bin/bash -c "source ~/.profile && ./configure -prefix=$COQ_PREFIX -no-ask"
docker exec -w /home/coq/coq fmcontainerbhvbedrock /bin/bash -c "source ~/.profile && make dunestrap"
docker exec -w /home/coq/coq fmcontainerbhvbedrock /bin/bash -c "source ~/.profile && dune build -p coq-core,coq-stdlib,coq,coqide-server"
docker exec -w /home/coq/coq fmcontainerbhvbedrock /bin/bash -c "source ~/.profile && dune install --prefix=$COQ_PREFIX coq-core coq-stdlib coq coqide-server"

docker exec fmcontainerbhvbedrock sudo apt update
docker exec fmcontainerbhvbedrock sudo apt -y install expect
docker stop fmcontainerbhvbedrock
docker commit fmcontainerbhvbedrock coqunbuffer
