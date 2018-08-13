#!/bin/bash
# SCRIPT_NAME:  weixin.sh
# DESCRIPTION:  send message from weixin for zabbix monitor
# DATE :        2017-06-07
CropID=''
Secret=''
#获取access_token
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CropID&corpsecret=$Secret"
Gtoken=$(/usr/bin/curl -s -G $GURL | awk -F\" '{print $10}')
PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Gtoken"
function body () {
   local Meg=$(echo "$@" | cut -d" " -f3-)
   echo """{
    \"touser\" : \"@all\",
    \"msgtype\" : \"text\",   
    \"agentid\" : 1,
    \"text\" : {           
        \"content\" : \"$Meg\"}   
}"""
}
/usr/bin/curl --data-ascii "$(body $1 $2 $3)" $PURL
