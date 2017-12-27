#!/bin/bash

# Open 4 panels
CMD_0="./ot-offline.x -N 2 -p 0 -c; bash"
CMD_1="echo '0'; bash"
CMD_2="./ot-offline.x -N 2 -p 1 -c; bash"
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
