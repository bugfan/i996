#!/usr/bin/env bash
#
# Description: NAT Shell Script v2 by sean bugfan
# Date: 2022.8.9
# Copyright (C) 2022  bugfan <bugfan53@gmail.com>
# URL: https://www.i996.me
# Github: https://github.com/bugfan
# 
#!/usr/bin/env bash

token=$1

sys_protocol="https://"
sys_host="api.i996.me"
message_update_private="ClothoUpdatePrivate"
message_broadcast="ClothoBroadcast"
message_bind_port="ClothoAllocatedPort"
message_sync_public_host="syncpublichost"
message_sync_private_host="syncprivatehost"
server_addr="i996.me"
server_port="8222"
public_host="xxxx.i996.me"
private_host="127.0.0.1:8080"
private_addr="127.0.0.1"
private_port="8080"
internal_fifo="./fifo.v2"
if [ ! -p ${internal_fifo} ]; then
    mkfifo ${internal_fifo}
fi

log(){
    t=$(date "+%Y-%m-%d.%H:%M:%S")
    echo '['${t}']-'
}
echon(){
    printf "\r%s" $1 
}
include(){
    tmp=$(echo $1 | grep "${2}")
    if [[ "$tmp" != "" ]]
    then
        return 1
    else
        return 0
    fi
}

output(){
    _public_host=${public_host}
    _private_host=${private_host}
    while IFS= read -r line ; do
        include "$line" $message_update_private
        up=$?
        if [ $up == 1 ]; then
            ps -ef | grep 'ssh -o StrictHostKeyChecking=no -R' | awk '{print $2}' | xargs kill -9
            continue
        fi
        include "$line" $message_sync_public_host
        syn=$?
        if [ $syn == 1 ]; then
            _public_host=${line#*$message_sync_public_host}
            continue
        fi
        include "$line" $message_sync_private_host
        syn=$?
        if [ $syn == 1 ]; then
            _private_host=${line#*$message_sync_private_host}
            continue
        fi
        include "$line" $message_bind_port
        stat=$?
        if [ ${#line} == '0' ]; then
            continue
        fi
        if [ $stat == 0 ]; then
            continue
        fi
        port=${line#*${message_bind_port}}
        echo $(log)"i996内网穿透启动成功！！！"
        echo $(log)"公网地址  =======> https://"$_public_host
        echo $(log)"..                 http://"$_public_host
        echo $(log)"..                 tcp://${_public_host}:${port}"
        echo $(log)"内网地址  =======> "$_private_host
        echo
        echo $(log)'【温馨提示】您正在使用i996新版本！新版在上一版的基础上增加了tcp和websocket!'
        echo $(log)'【温馨提示】新版暂不支持日志打印功能!详细情况请看https://www.i996.me或加QQ群805010167交流!'
    done < "${internal_fifo}"
    echo $(log)"正在尝试重连,请稍等～【可能您更新了配置,也可能是i996服务器管理员正在更新升级新功能】"
}
check_token(){
    echo $(log)"验证Token中..."
    if [ -z "${1}" ]; then
        return 1
    fi
    msg=$(curl -s -X POST ''$sys_protocol$sys_host'/sys-auth' -H 'ClothoVersion: v2' -H 'Authorization: '${1}'')
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
    info=${msg#*$message_broadcast}
    public_host=${info%%|*}
    private_host=${info#*|}
    private_addr=${private_host%%:*}
    private_port=${info#*:}
    return 0
}
work(){
    if [ ${#token} == '0' ];then
        echo $(log)'请指定Token参数!(curl -s v2.i996.me | bash -s Token)'
        exit 0
    fi
    check_token $token
    state=$?
    if [ $state == 0 ]; then
        echo $(log)'Token验证通过!'
    fi
    if [ $state == 2 ]; then
        echo $(log)'抱歉,服务器可能暂时出了点问题!请稍后再尝试～'
        exit 0
    fi
    if [ $state == 1 ]; then
        echo $(log)'Token验证失败!请关注"敲代码斯基"公众号获取Token!(免费)'
        exit 0
    fi
    echo "${message_sync_public_host}${public_host}" > ${internal_fifo}
    echo "${message_sync_private_host}${private_host}" > ${internal_fifo}
    ssh -o StrictHostKeyChecking=no -R 0:${private_addr}:${private_port} ${token}@${server_addr} -p ${server_port} > ${internal_fifo} 2>&1
    echo $(log)"网络断开了😭～"
}

# finish func
finish(){
    kill ${output_pid} 2>/dev/null
    echo '撤退了～'
    rm ${internal_fifo}
    exit 0
}

# catch "Ctrl + c" "Exit"
trap finish EXIT SIGTERM SIGINT SIGQUIT

run(){
    
    while :
    do
        output & 2>/dev/null
        output_pid=$!
        # printf "worker pid:%s\n" ${output_pid}
        work
        sleep 1
    done
}
