#!/bin/bash

# NETW 217 Final Project - Hands On
# Menu-driven administration program (Bash)
# 1. Show IP (Shows IP and Gateway Only)
# 2. Show Gateway (Show Gateway Only)
# 3. Enable/Disable Firewall
# 4. Check/Change Machine Hostname
# 5. Linux Distribution (Show only the distribution name)
# 6. Run software updates
# 7. Check memory
# 8. Remaining storage space.

# Function to show the menu
show_menu() {
    echo ""
    echo "--=== Administration Program ===--"
    echo "1. Show IP"
    echo "2. Show Gateway"
    echo "3. Enable Firewall"
    echo "4. Disable Firewall"
    echo "5. Check/Change Hostname"
    echo "6. Linux Distribution"
    echo "7. Run Software Updates"
    echo "8. Check Memory"
    echo "9. Remaining Storage Space"
    echo "10. Exit"
    echo -n "Select a number (1-10): "
}

# 1. Show IP --- Shows The IP & Gateway Only 
show_ip_gateway() {
    echo ""
    echo "IP Address and Gateway:"
    ip -4 addr show | grep inet
    ip route | grep default | awk '{print "Gateway: "$3}'
}

# 2. Show Gateway --- ShowS Gateway Only
show_gateway() {
    echo ""
    echo "Default Gateway:"
    ip route | grep default | awk '{print $3}'
}

# 3. Enable Firewall
enable_firewall() {
    echo ""
    echo "Enabling Firewall..."
    sudo ufw enable
}

# 3. Disable Firewall
disable_firewall() {
    echo ""
    echo "Disabling Firewall..."
    sudo ufw disable
}

# 4. Checks / Changes Machine Hostname
check_change_hostname() {
    echo ""
    echo "Current Hostname: $(hostname)"
    echo -n "Enter new hostname (or leave blank to keep current): "
    read new_hostname
    if [ ! -z "$new_hostname" ]; then
        sudo hostnamectl set-hostname "$new_hostname"
        echo "Hostname changed to $new_hostname."
    else
        echo "Hostname not changed."
    fi
}

# 5. Linux Distribution --- Shows Only The Distribution Name
show_linux_distribution() {
    echo ""
    echo "Linux Distribution:"
    cat /etc/*release | grep -E "NAME=" | cut -d'=' -f2 | tr -d '"'
}

# 6. Runs Software Updates
run_updates() {
    echo ""
    echo "Running Software Updates..."
    sudo apt update && sudo apt upgrade -y
}

# 7. Checks Memory
check_memory() {
    echo ""
    echo "Memory Usage:"
# Display amount of free and used memory in the system
    free -h
}

# 8. Shows Remaining Storage Space
check_storage() {
    echo ""
    echo "Remaining Storage Space:"
# Report file system disk space usage
    df -h /
}
