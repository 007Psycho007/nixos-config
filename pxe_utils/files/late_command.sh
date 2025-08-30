#!/bin/bash
set -euxo pipefail


cd "$(dirname "$0")"
touch start.txt
api_key=$(curl -s http://10.200.4.12:8888/snipe_api)

# CPU Model
category=`hostnamectl | grep Chassis | cut -d: -f2` 
cpu_model=`cat /proc/cpuinfo | grep 'model name' | uniq | cut -c14-39 | sed -e 's/([^()]*)//g' | tr -d ' ' | cut -c -12`
# OS Distribution and Version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    os_distro="$NAME"
    os_version="$VERSION"
else
    os_distro="Unknown"
    os_version="Unknown"
fi

# Total RAM
total_ram=$(awk '/MemTotal:/ { print int($2/1024/1024+0.5) }' < /proc/meminfo)

# Free space on root (/)
free_space=$(df -h / | awk 'NR==2 { print $4 }')

if [[ $category =~ "laptop" || $category =~ "notebook" ]]; then\
		echo "Information ueber Laptop sammeln"
                model=2
                battery=`acpi -V | grep '^Battery.*%$' | tail -c 4`
                display=`xrandr | awk '/ connected/{print sqrt( ($(NF-2)/10)^2 + ($NF/10)^2 )/2.54}' | cut -c -2 | head -n 1`
 else
                model=1
fi
# You can now use these variables as needed
# For example, to print them later:

if [[ $(lsblk | grep sr0) ]]; then
      odd=ja
else
      odd=nein
fi

mac=`ip link | sed -n "/BROADCAST.*state UP/{n;p}" | tail -1 | tr -s " " | cut -d" " -f3`
serialno=`sudo dmidecode -s system-serial-number`
name=`echo $os_distro/$os_version/$cpu_model/$total_ram/$free_space`
anydeskid=4711
echo $name
post_data() {
    cat << EOF
{
  "status_id": "2",
  "name": "$name",
  "model_id": "$model",
  "serial": "$serialno",
  "_snipeit_mac_address_1": "$mac",
  "_snipeit_betriebssystem_2": "$os_distro $os_version",
  "_snipeit_festplatte_4": "$free_space",
  "_snipeit_prozessor_5": "$cpu_model",
  "_snipeit_arbeitsspeicher_6": "$total_ram",
  "_snipeit_optisches_laufwerk_7": "$odd",
  "_snipeit_display_8": "$display",
  "_snipeit_akku_9": "$battery",
  "_snipeit_anydeskid_10": "$anydeskid"
}
EOF
}



curl 	--request GET \
	--url 'https://computer.z31.it/api/v1/hardware?limit=5&search='$mac'' \
	--header 'accept: application/json' \
	--header 'authorization: Bearer '$api_key'' \
	--header 'content-type: application/x-www-form-urlencoded' > ./check_result.json

asset_tag=$(jq -j .rows[].asset_tag ./check_result.json)

if [ ! -z ${asset_tag} ]
then
	zenity --info --text "Der Rechner ist ist bereits eingetragen RE${asset_tag}" --width=500 --height=200
	#echo " Der Rechner ist bereits eingetragen RE${asset_tag}"
	exit 0
fi

echo registering Computer $(post_data)
curl --request POST \
	--url https://computer.z31.it/api/v1/hardware \
	--header 'accept: application/json' \
	--header 'authorization: Bearer '$api_key'' \
	--header 'Content-Type: application/json' \
	--data "$(post_data)" > ./result.json


# get missing information from payload
asset_tag=$(cat ./result.json | jq -r '.payload.asset_tag')
result_jq=$(cat ./result.json | jq -r '.status')
erstellt_am=$(cat ./result.json | jq -r '.payload.created_at')

echo "$asset_tag" > ./asset.txt
echo "Asset Text from Server"
cat ./asset.txt

print_data() {
    cat << EOF
{
	"id": "$asset_tag",
	"distribution": "$os_distro",
	"version": "$os_version",
	"cpu": "$cpu_model",
	"memory": "$total_ram",
	"disk": "$free_space"
}
EOF
}

curl --request POST -d "$(print_data)" http://10.200.4.12:8888/label
# | lpr -H 10.200.4.12:631 -P DYMO -o landscape -
