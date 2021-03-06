#!/bin/bash

if [ "$1" == "" ]; then {
    COIN=bitcoin
    }
else {
    COIN=$1
    } fi

clear
cat <<EOF
--------
You can either download the ${COIN} prebuilt container from dockerhub
or you can build it from the 'generate' template folder (perhaps if you
have made modifications).
--------

EOF
echo -n "Would you like to build the image locally from $COIN/generate?
y/N: "

read CHOICE
if [ "${CHOICE,,}" == "y" ] || [ "${CHOICE,,}" == "yes" ]; then {
    cd generate/ && \
    bash setup.sh $COIN && \
    cd ..
    }
else {
    docker pull coinclone/$COIN
    wait
    } fi

# Pull the precompiled clone container, run it and save the result
docker run -it --name ${COIN}_seed coinclone/$COIN $COIN && \
docker commit ${COIN}_seed coinclone/$COIN:node && \
docker rm ${COIN}_seed
