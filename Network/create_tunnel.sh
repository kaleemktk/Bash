#!/bin/bash
if [[ -z $1 ]]; then
        echo "Usage $0 <ip_address_of_bmc>"
        exit 1
fi
export ip=$1
trap trap_ctrl_c SIGINT
function trap_ctrl_c() {
        echo -e "\033[0;31mKilling SSH Tunnels and BG_Tmux_Session \033[0m"
        tmux kill-session -t s_tun
        echo "kill `pgrep -P $$` > /dev/null 2>&1"
        exit $?
}
create_tun () {
        sleep 1
        ssh -N -T -L 4445:$ip:443 root@eng1 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
}
while true; do
        echo "Creating Tunnel LocalHost:4445 to $ip :443"
        type create_tun | sed '1,/{/d' | sed '/}/Q' > /dev/shm/CreateTun.sh
        tmux new -s s_tun -d 'source /dev/shm/CreateTun.sh ; rm /dev/shm/CreateTun.sh ; tmux wait-for -S s_tun_done'
        echo -e "\033[0;32m############################################"
        echo -e " SSH TUNNELED Proc Running in BG_Tmux: s_tun"
        echo -e "############################################\033[0m"
        while tmux has-session -t s_tun ; do
                sleep 5
        done
done
