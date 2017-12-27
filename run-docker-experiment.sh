#!/bin/bash

# Launch a network with 4 docker images.
# Build one shell for each, in order to attach

# Build dockerfile
docker build -t spdz2 -f docker-mascot/Dockerfile . || exit

# With 2 nodes
CMD_0="docker rm -f spdz2-1; docker run -it --network local_alias --network-alias spdz2-1 --name spdz2-1 spdz2 ./ot-offline.x -N 2 -p 0 -c; bash"
CMD_1="bash"
CMD_2="docker rm -f spdz2-2; docker run -it --network local_alias --network-alias spdz2-2 --name spdz2-2 spdz2 ./ot-offline.x -N 2 -p 1 -c; bash"
CMD_3="bash"

# With 3 nodes
#CMD_0="echo '0'; bash"
#CMD_1="docker rm -f spdz2-1; docker run -it --network local_alias --network-alias spdz2-1 --name spdz2-1 spdz2 ./ot-offline.x -N 3 -p 0 -c; bash"
#CMD_2="docker rm -f spdz2-2; docker run -it --network local_alias --network-alias spdz2-2 --name spdz2-2 spdz2 ./ot-offline.x -N 3 -p 1 -c; bash"
#CMD_3="docker rm -f spdz2-3; docker run -it --network local_alias --network-alias spdz2-3 --name spdz2-3 spdz2 ./ot-offline.x -N 3 -p 2 -c; bash"

# Layout for 4 panels in TMUX
#
#  +-----+-----+
#  |  0  |  2  |
#  +-----+-----+
#  |  1  |  3  |
#  +-----+-----+
#

tmux new-session  "${CMD_0}" \;  \
     splitw -h -p 50 "${CMD_2}" \;  \
     splitw -v -p 50 "${CMD_3}" \;  \
     selectp -t 0 \;  \
     splitw -v -p 50 "${CMD_1}"
