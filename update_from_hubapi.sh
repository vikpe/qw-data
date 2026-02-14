mkdir -p hubapi

curl https://hubapi.quakeworld.nu/v2/servers > servers.json

jq servers.json --raw-output '.[] | select(.geo.region == "Europe" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_europe.txt
wc -l hubapi/servers_mvdsv_europe.txt

jq servers.json --raw-output '.[] | select(.geo.region == "North America" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_north_america.txt
wc -l hubapi/servers_mvdsv_north_america.txt

jq servers.json --raw-output '.[] | select(.geo.region == "South America" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_south_america.txt
wc -l hubapi/servers_mvdsv_south_america.txt
