mkdir -p hubapi

curl https://hubapi.quakeworld.nu/v2/servers > servers.json

jq --raw-output '.[] | select(.geo.region == "Europe" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' servers.json | sort > hubapi/servers_mvdsv_europe.txt
wc -l hubapi/servers_mvdsv_europe.txt

jq --raw-output '.[] | select(.geo.region == "North America" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' servers.json | sort > hubapi/servers_mvdsv_north_america.txt
wc -l hubapi/servers_mvdsv_north_america.txt

jq --raw-output '.[] | select(.geo.region == "South America" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' servers.json | sort > hubapi/servers_mvdsv_south_america.txt
wc -l hubapi/servers_mvdsv_south_america.txt
