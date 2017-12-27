#!/bin/bash

# Assumes SPDZ-2 has been built with CONFIG-she

./compile.py tutorial

# For 2 nodes
CMD_0="./spdz2-offline.x -N 2 -p 0; bash"
CMD_1="./spdz2-offline.x -N 2 -p 1; bash"
CMD_2="echo '2'; bash"
CMD_3="echo '3'; bash"

# For 3 nodes
CMD_0="./spdz2-offline.x -N 3 -p 0; bash"
CMD_1="./spdz2-offline.x -N 3 -p 1; bash"
CMD_2="./spdz2-offline.x -N 3 -p 2; bash"
CMD_3="echo '3'; bash"

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
