#!/bin/sh
## update LATITUDE and LONGITUDE env values (i.e for file .bash_profile)

file="${HOME}/.bash_profile"
content=$(curl -s http://ip-api.com/json/)
longitude=$(echo $content | jq .lon)
latitude=$(echo $content | jq .lat)

profile_lat_line=$(grep "export LATITUDE=" ${file})
profile_lng_line=$(grep "export LONGITUDE=" ${file})
sed -i -e "s/${profile_lat_line}/export LATITUDE=\"${latitude}\"/g" ${file}
sed -i -e "s/${profile_lng_line}/export LONGITUDE=\"${longitude}\"/g" ${file}
