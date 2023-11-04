mkdir -p hubapi

curl https://hubapi.quakeworld.nu/v2/servers | jq --raw-output '.[] | select(.geo.region == "Europe" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_europe.txt
wc -l hubapi/servers_mvdsv_europe.txt

curl https://hubapi.quakeworld.nu/v2/servers | jq --raw-output '.[] | select(.geo.region == "North America" and (.version | startswith("MVDSV"))) | .settings.hostname_parsed' | sort > hubapi/servers_mvdsv_north_america.txt
wc -l hubapi/servers_mvdsv_north_america.txt
