#!/bin/sh
exec uwsm app -a "minecraft-$INST_ID" -d "Minecraft ($INST_NAME)" -- "$@"
