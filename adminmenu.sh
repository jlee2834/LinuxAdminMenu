#!/bin/bash

# This script shows a simple menu with options to perform basic tasks on your computer.

# Function to show the menu
show_menu() {
    echo ""
    echo "===== Admin Menu ====="
    echo "1. Show IP and Gateway"
    echo "2. Show Gateway"
    echo "3. Enable Firewall"
    echo "4. Disable Firewall"
    echo "5. Check or Change Hostname"
    echo "6. Show Linux Distribution"
    echo "7. Run Software Updates"
    echo "8. Check Memory Usage"
    echo "9. Show Remaining Storage Space"
    echo "10. Exit"
    echo -n "Enter your choice (1-10): "
}

# Function to show the IP address and gateway
show_ip_gateway() {
    echo ""
    echo "IP Address and Gateway:"
    ip -4 addr show | grep inet
    ip route | grep default | awk '{print "Gateway: "$3}'
}

# Function to show just the gateway
show_gateway() {
    echo ""
    echo "Default Gateway:"
    ip route | grep default | awk '{print $3}'
}

# Function to enable the firewall
enable_firewall() {
    echo ""
    echo "Enabling Firewall..."
    sudo ufw enable
}

# Function to disable the firewall
disable_firewall() {
    echo ""
    echo "Disabling Firewall..."
    sudo ufw disable
}

# Function to check or change the hostname
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

# Function to show the Linux distribution name
show_linux_distribution() {
    echo ""
    echo "Linux Distribution:"
    cat /etc/*release | grep -E "NAME=" | cut -d'=' -f2 | tr -d '"'
}

# Function to run software updates
run_updates() {
    echo ""
    echo "Running Software Updates..."
    sudo apt update && sudo apt upgrade -y
}

# Function to check memory usage
check_memory() {
    echo ""
    echo "Memory Usage:"
    free -h
}

# Function to show the remaining storage space
check_storage() {
    echo ""
    echo "Remaining Storage Space:"
    df -h /
}

# Main loop
do_exit=false
while [ "$do_exit" = false ]; do
    show_menu
    read choice
    case $choice in
        1) show_ip_gateway ;;
        2) show_gateway ;;
        3) enable_firewall ;;
        4) disable_firewall ;;
        5) check_change_hostname ;;
        6) show_linux_distribution ;;
        7) run_updates ;;
        8) check_memory ;;
        9) check_storage ;;
        10) do_exit=true ;;
        *) echo "Invalid choice, please try again." ;;
    esac
    echo ""
    echo "Press Enter to continue..."
    read
done

echo "Exiting Admin Menu. Goodbye!"
