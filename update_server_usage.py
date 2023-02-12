import json
import time
import requests

USAGE_FILE_PATH = "hubapi/server_usage.json"


def load_usage() -> dict:
    with open(USAGE_FILE_PATH) as fp:
        return json.load(fp)


def save_usage(data: dict):
    sorted_data = {}

    for key in sorted(data):
        sorted_data[key] = data[key]

    with open(USAGE_FILE_PATH, "w") as fp:
        json.dump(sorted_data, fp, indent=2)


def get_servers():
    mvdserver_url = "https://hubapi.quakeworld.nu/v2/servers/mvdsv"
    return requests.get(mvdserver_url).json()


def main():
    servers = get_servers()
    server_usage = load_usage()
    timestamp = round(time.time())

    for server in servers:
        hostname = server["settings"]["hostname_parsed"]

        if hostname not in server_usage:
            server_usage[hostname] = {
                "hostname": server["settings"]["hostname"],
                "player_count": {}
            }

        server_usage[hostname]["player_count"][timestamp] = server["player_slots"]["used"]

    save_usage(server_usage)


main()
