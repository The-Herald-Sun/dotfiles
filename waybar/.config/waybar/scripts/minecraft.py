#!/home/sam/.config/waybar/scripts/mcstatus_venv/bin/python3

import sys

from mcstatus import JavaServer

SERVER_ADDRESS = "www.minecraft.sammason.au"
SERVER_PORT = 25565

try:
    full_server_address = f"{SERVER_ADDRESS}:{SERVER_PORT}"

    server = JavaServer.lookup(full_server_address)
    status = server.status()

    online_players = status.players.online

    print(f"{online_players}")

except Exception as e:
    print("offline")
    sys.exit(1)
