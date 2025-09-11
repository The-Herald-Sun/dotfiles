#!/home/sam/.config/waybar/scripts/mcstatus_venv/bin/python3

import sys
import json

from mcstatus import JavaServer

SERVER_ADDRESS = "www.minecraft.sammason.au"
SERVER_PORT = 25565

try:
    full_server_address = f"{SERVER_ADDRESS}:{SERVER_PORT}"

    server = JavaServer.lookup(full_server_address)
    status = server.status()

    online_players = status.players.online

    waybar_data = {"text": online_players, "tooltip": "", "class": "minecraft"}

    players = status.players.sample
    if players:
        for player in players:
            waybar_data["tooltip"] += f"{player.name},\n"
        waybar_data["tooltip"] = waybar_data["tooltip"][:-2]  # remove last new line
    else:
        waybar_data["tooltip"] = "No Players Online"
    print(json.dumps(waybar_data))

except Exception as e:
    # print(e)
    waybar_data = {"text": "\uf4ad", "tooltip": "Server Offline", "class": "minecraft"}
    print(json.dumps(waybar_data))
    sys.exit(0)
