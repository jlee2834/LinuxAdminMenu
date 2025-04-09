#!/bin/bash

# NETW 217 Final Project - Hands On Admin Script
# Sources used: man pages (man hostnamectl, man ip, man free, man df), Ubuntu/Debian docs, Linux Mint forums

# Function to show the menu
# Displays all available options to the user
show_menu() {
    echo ""
    echo "--=== Linux Mint Administration Menu ===--"
    echo "1. Show IP and Gateway"
    echo "2. Show Gateway Only"
    echo "3. Enable Firewall"
    echo "4. Disable Firewall"
    echo "5. Check/Change Hostname"
    echo "6. Show Linux Distribution"
    echo "7. Run Software Updates"
    echo "8. Check Memory"
    echo "9. Remaining Storage Space"
    echo "10. Exit"
    echo -n "Select a number (1-10): "
}

# 1. Show IP and Gateway (https://serverfault.com/questions/31170/how-to-find-the-gateway-ip-address-in-linux)
# Simplified: hostname -I for IP, ip route show default for gateway
show_ip_gateway() {
    echo -e "\n[IP Address and Gateway]"
    ip_addr=$(hostname -I | awk '{print $1}')
    gateway=$(ip route show default | awk '/default/ {print $3}')
    echo "IP Address: $ip_addr"
    echo "Gateway: $gateway"
}

# 2. Show Gateway Only (https://serverfault.com/questions/31170/how-to-find-the-gateway-ip-address-in-linux)
# Simplified version of default gateway lookup
show_gateway() {
    echo -e "\n[Gateway]"
    gateway=$(ip route show default | awk '/default/ {print $3}')
    echo "Gateway: $gateway"
}

# 3. Enable Firewall (https://www.cyberciti.biz/faq/linux-disable-firewall-command/)
enable_firewall() {
    sudo ufw enable && echo "Firewall is enabled :)"
}

# 4. Disable Firewall (https://www.cyberciti.biz/faq/linux-disable-firewall-command/)
disable_firewall() {
    sudo ufw disable && echo "Firewall is disabled :("
}

# 5. Check/Change Hostname (https://www.redhat.com/en/blog/configure-hostname-linux)
check_change_hostname() {
    echo -e "\n[Hostname Options]"
    echo "Hostname: $(hostname)"
    read -p "Enter New Hostname:" new_hostname
    if [ ! -z "$new_hostname" ]; then
        sudo hostnamectl set-hostname "$new_hostname"
        echo "Hostname changed to $new_hostname."
    else
        echo "Hostname not changed."
    fi
}

# 6. Show Linux Distribution (https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/)
show_linux_distribution() {
    echo -e "\n[Linux Distribution]"
    distro=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
    echo "Distribution: $distro"
}

# 7. Run Software Updates
# Runs apt update and upgrade
run_updates() {
    echo -e "\n[Running Software Updates]"
    sudo apt update && sudo apt upgrade -y
    echo "Software Updated"
}

# 8. Check Memory Usage (https://unix.stackexchange.com/questions/119126/command-to-display-memory-usage-disk-usage-and-cpu-load)
# Displays memory status in human-readable format
check_memory() {
    echo -e "\n[Memory Usage]"
    free -h
}

# 9. Check Remaining Storage Space (https://www.howtogeek.com/409611/how-to-view-free-disk-space-and-disk-usage-from-the-linux-terminal/)
# Shows root partition disk usage
check_storage() {
    echo -e "\n[Remaining Storage Space]"
    df -h /
}

# Main loop that keeps the menu running until user exits
while true; do
    show_menu
    read choice
    case $choice in
        1) show_ip_gateway;;
        2) show_gateway;;
        3) enable_firewall;;
        4) disable_firewall;;
        5) check_change_hostname;;
        6) show_linux_distribution;;
        7) run_updates;;
        8) check_memory;;
        9) check_storage;;
        10) echo "Exiting program."; break;;
        *) echo "Invalid option. Please choose 1–10.";;
    esac
done
