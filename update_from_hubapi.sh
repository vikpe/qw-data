sudo apt install jq -y

mkdir -p hubapi

curl https://hubapi.quakeworld.nu/v2/servers | jq --raw-output '.[] | select(.geo.region == "Europe" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_europe.txt
