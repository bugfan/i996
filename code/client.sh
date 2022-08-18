#!/usr/bin/env bash
#
# Description: A NAT Shell Script by sean bugfan
# Date: 2022.7.1
# Copyright (C) 2022 - Now  bugfan <bugfan53@gmail.com>
# URL: https://www.i996.me
# Github: https://github.com/bugfan
# 
access_token=$1
pipe_dir="/tmp/clotho/"
if [ -d ${pipe_dir} ]; then
    rm -rf ${pipe_dir}
fi
if [ ! -d ${pipe_dir} ]; then
    mkdir ${pipe_dir}
fi
pipe_websocket=$(echo ${pipe_dir}"websocket")
if [ ! -p ${pipe_websocket} ]; then
    mkfifo ${pipe_websocket}
fi
pipe_internal=$(echo ${pipe_dir}"internal")
if [ ! -p ${pipe_internal} ]; then
    mkfifo ${pipe_internal}
fi

message_request="ClothoHTTPRequest"
message_broadcast="ClothoBroadcast"
message_key="ClothoMsg"


sys_protocol="https://"
sys_host="api.i996.me"
public_host="xxxx.i996.me"
private_host="http://127.0.0.1:8080"
wxtoken="xxxx"

include(){
    tmp=$(echo $1 | grep "${2}")
    if [[ "$tmp" != "" ]]
    then
        return 1
    else
        return 0
    fi
}

log(){
    t=$(date "+%Y-%m-%d %H:%M:%S")
    echo '['${t}'] - '
}

check_token(){
    echo $(log)"验证Token中..."
    if [ -z "${1}" ]; then
        return 1
    fi
    msg=$(curl -s --http1.1 -X POST ''$sys_protocol$sys_host'/sys-auth' -H 'Authorization: '${1}'')
    if [ $? != 0 ]; then
        return 2 
    fi

    include $msg $message_broadcast
    stat=$?
    if [ ${#msg} == '0' ]; then
        return 1
    fi
    if [ $stat == 0 ]; then
        return 1
    fi
    wxtoken=${1}
    info=${msg#*$message_broadcast}
    private_host=${info#*|}
    public_host=${info%%|*}
    return 0
}

new_fifo_name(){
    echo $1$2
}
last_n(){
    echo ${1: -${2}}
}
request_url(){
    tmp=${1%\'*}
    echo ${tmp##*\'}
}
execute_sec(){
    tmp="${1#*real}"
    u=${tmp%%s*}
    echo "耗时 "${u}'s'
}
string_index(){ 
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1 || echo ${#x}
}

do_request(){
    # get message id
    tmp="${1#*${message_key}:}"
    message_id=${tmp%%\'*}
    if [ ${#message_id} -lt 5 ]; then
        echo $(log)"error message:"$message_id
        return
    fi
    show_id="***"$(last_n $message_id 6)
    echo $(log)${show_id}" ====> "$(request_url "${1}")

    internal_fifo=$(new_fifo_name ${pipe_dir} ${message_id})
    mkfifo ${internal_fifo}

    response ${message_id} ${internal_fifo} &
    exec_res=$(time (eval "${1}" > ${internal_fifo}) 2>&1)
    echo $(log)${show_id}" <==== "$(execute_sec "${exec_res}")
    rm ${internal_fifo}
}

response(){
    curl -X POST --http1.1 -v ''$sys_protocol$sys_host'/sys-callback' -H 'Authorization: '${wxtoken}'' -H 'ClothoMsg: '${1}'' --data-binary '@'${2}'' 2>/dev/null
}

handle(){
    msg=${1}
    include $msg $message_request
    req=$?
    if [ $req > 0 ]; then
        payload=${msg#*$message_request}
        # printf "%s\n" $payload
        cmd=$(echo $payload|base64 -d)
        do_request "$cmd" &
    fi


}

read_io(){
    # tail -f ${pipe_websocket} | while read -r line ; do
    while IFS= read -r line ; do
        handle "${line}"
    done < "${pipe_websocket}"
    echo $(log)"链接出现了异常..."
}


sys_connect(){
    # check token
    token=${access_token}
    if [ ${#token} == '0' ];then
        echo $(log)'请指定Token参数!(curl -s i996.me | bash -s Token)'
        exit 0
    fi
    check_token $token
    state=$?
    if [ $state == 0 ]; then
        echo $(log)"内网穿透启动成功!!! "
        echo $(log)"公网地址  =======> https://"$public_host
        echo $(log)"..                 http://"$public_host
        echo $(log)"内网地址  =======> "$private_host
    fi
    if [ $state == 2 ]; then
        echo $(log)'抱歉,服务器可能暂时出了点问题!请稍后再尝试～'
        break
    fi
    if [ $state == 1 ]; then
        echo $(log)'Token验证失败!请关注"敲代码斯基"公众号获取Token!(免费)'
        exit 0
    fi

    # listen conn
    read_io & 2>/dev/null
    read_io_pid=$!
    # printf "worker pid:%s\n" ${read_io_pid}

    # do connect
    curl -s --no-buffer --http1.1 -H 'Authorization: '${wxtoken}'' -H 'Connection: keep-alive, Upgrade' -H 'Upgrade: websocket' -v -H 'Sec-WebSocket-Version: 13' -H 'Sec-WebSocket-Key: websocket' ''$sys_protocol$sys_host'/sys-ws' ws -o ${pipe_websocket} 2>/dev/null
    echo $(log)"链接中断了! 正在尝试重新链接...."
    kill ${read_io_pid} 2>/dev/null
}

# finish func
finish () {
    if [ '${read_io_pid}' == '' ];then
        kill ${read_io_pid}
    fi
    rm -rf ${pipe_dir}
    if [ -p 0 ]; then
        rm 0
    fi
    exit 0
}

# catch "Ctrl + c" "Exit"
trap finish EXIT SIGTERM SIGINT SIGQUIT

run(){
    while :
    do
        sys_connect
        sleep 3
    done
}

run


# # Inifinite sleep
# sleep infinity
# wait $!
