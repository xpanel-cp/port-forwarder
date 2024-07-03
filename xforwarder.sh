#!/bin/bash

install_req() {
    clear
    # Check OS and set release variable
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        release=$ID
    elif [[ -f /usr/lib/os-release ]]; then
        source /usr/lib/os-release
        release=$ID
    else
        echo "Failed to check the system OS, please contact the author!" >&2
        exit 1
    fi

    echo "The OS release is: $release"

    case "${release}" in
        centos | fedora | almalinux)
            yum upgrade && yum install -y -q net-tools
            touch epfinstalled
            ;;
        arch | manjaro)
            pacman -Sy --noconfirm net-tools inetutils
            touch epfinstalled
            ;;
        *)
            apt update && apt install -y -q net-tools iptables-persistent
            touch epfinstalled
            ;;
    esac

    read -p "Press Enter to return to the menu."
}

port_to_port() {
    clear
    echo -e "█▓▒▒░░░XPANEL Port Forwarder░░░▒▒▓█"

    publicIP=$(hostname -I | awk '{print $1}')
    interface=$(route | grep '^default' | grep -o '[^ ]*$')

    echo "Enabling IP Forwarding"
    sysctl net.ipv4.ip_forward=1 >/dev/null 2>&1

    read -p "Enter IP Server 2: " ip
    read -p "Enter IN Port: " ports
    read -p "Enter OUT Port: " dport
    read -p "Enter Protocol Type TCP/UDP: " proto

    echo "Moving Port $ports to $ip:$dport"
    iptables -t nat -A PREROUTING -p $proto --dport $ports -j DNAT --to-destination $ip:$dport
    echo "Finalizing Changes in IP Tables."
    iptables -t nat -A POSTROUTING -j MASQUERADE -o $interface

    read -p "Press Enter to return to the menu."
}

all_forward() {
    clear
    echo -e "█▓▒▒░░░XPANEL Port Forwarder░░░▒▒▓█"

    publicIP=$(hostname -I | awk '{print $1}')
    interface=$(route | grep '^default' | grep -o '[^ ]*$')

    echo "Enabling IP Forwarding"
    sysctl net.ipv4.ip_forward=1 >/dev/null 2>&1

    read -p "Enter IP Server 2: " ip
    read -p "Enter Protocol Type TCP/UDP: " proto

    echo "Moving all ports to $ip"
    iptables -t nat -A PREROUTING -p $proto -j DNAT --to-destination $ip
    echo "Finalizing Changes in IP Tables."
    iptables -t nat -A POSTROUTING -j MASQUERADE -o $interface

    read -p "Press Enter to return to the menu."
}

nat() {
    clear
    echo -e "█▓▒▒░░░XPANEL Port Forwarder░░░▒▒▓█"

    publicIP=$(hostname -I | awk '{print $1}')
    interface=$(route | grep '^default' | grep -o '[^ ]*$')

    echo "Enabling IP Forwarding"
    sysctl net.ipv4.ip_forward=1 >/dev/null 2>&1

    read -p "Enter IP Server 2: " ip

    echo "Moving NAT to $ip"
    iptables -t nat -A PREROUTING -j DNAT --to-destination $ip
    echo "Finalizing Changes in IP Tables."
    iptables -t nat -A POSTROUTING -j MASQUERADE -o $interface

    read -p "Press Enter to return to the menu."
}

flush() {
    clear
    echo "Stopping IPv4 firewall and allowing everyone..."
    ipt="/sbin/iptables"
    [ ! -x "$ipt" ] && {
        echo "$0: \"${ipt}\" command not found."
        exit 1
    }
    $ipt -P INPUT ACCEPT
    $ipt -P FORWARD ACCEPT
    $ipt -P OUTPUT ACCEPT
    $ipt -F
    $ipt -X
    $ipt -t nat -F
    $ipt -t nat -X
    $ipt -t mangle -F
    $ipt -t mangle -X
    $ipt -t raw -F
    $ipt -t raw -X

    sleep 3
    read -p "Press Enter to return to the menu."
}

menu() {
    while true; do
        clear
        echo "█▓▒▒░░░XPANEL Port Forwarder░░░▒▒▓█"
        PS3='Please enter your choice: '
        options=("Install Library" "All Port Forward" "NAT Forward" "Port to Port" "Flush Rules" "Save Rules" "Show Rules" "Show Network Interfaces" "Check IP Forwarding" "View IP Rules" "Quit")

        printf "\n"
        for i in "${!options[@]}"; do
            printf "%d) %s\n" "$((i+1))" "${options[i]}"  # Print options with numbers
        done
        printf "\n"

        read -rp "Please enter your choice: " choice
        case $choice in
            1) install_req ;;
            2) all_forward ;;
            3) nat ;;
            4) port_to_port ;;
            5) flush ;;
            6) sudo /sbin/iptables-save >/etc/iptables/rules.v4
               echo "Saved." ;;
            7) sudo iptables -L -v -n
               sudo iptables -t nat -L -v -n ;;
            8) ip -br a ;;
            9) sysctl net.ipv4.ip_forward ;;
            10) sudo iptables -L -v -n ;;
            11) exit 0 ;;
            *) echo "Invalid option. Please enter a number from 1 to 11." ;;
        esac

        read -p "Press Enter to continue..."
    done
}

# Start the menu initially
menu
