set -e

mkdir -p hubapi

geo=$(mktemp)
curl -sSf https://api.quake.world/v1/servers -o servers.json
curl -sSf https://raw.githubusercontent.com/vikpe/qw-servers-geoip/refs/heads/main/ip_to_geo.json -o "$geo"

# "hostname:port" if the server hostname starts with one, else "ip:port"
jq_hostport='
def hostport:
  "^[a-z0-9]([a-z0-9-]*[a-z0-9])?(\\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)+" as $host
  | ((.info.hostname // "") | ascii_downcase | split(" ")[0]) as $name
  | if (.info.hostport // "") != "" then .info.hostport
    elif ($name | test($host + ":[0-9]+$")) then $name
    elif ($name | test($host + "$")) then "\($name):\(.port)"
    else .address
    end;
'

for region in "Europe" "North America" "South America"; do
  file="hubapi/servers_mvdsv_$(echo "$region" | tr 'A-Z ' 'a-z_').txt"
  jq --raw-output --arg region "$region" --slurpfile geo "$geo" "$jq_hostport"'
    .[]
    | select(.software_type == "mvdsv" and $geo[0][.ip].region == $region)
    | hostport
  ' servers.json | LC_ALL=C sort > "$file"
  wc -l "$file"
done

rm "$geo"
