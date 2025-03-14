#!/bin/bash

LOG_DIR="/home/hasro71/modul_1/soal_2/logs"
CPU_LOG="$LOG_DIR/core.log"
RAM_LOG="$LOG_DIR/fragment.log"

# Membuat direktori log jika belum ada
mkdir -p "$LOG_DIR"

# Fungsi untuk mendapatkan informasi CPU
function get_cpu_info() {
    CPU_USAGE=$(top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}')
    CPU_MODEL=$(lscpu | grep "Model name:" | sed -E 's/Model name:\s+//')
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] - Core Usage [$CPU_USAGE%] - Terminal Model [$CPU_MODEL]" >> "$CPU_LOG"
}

# Fungsi untuk mendapatkan informasi RAM
function get_ram_info() {
    RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    RAM_COUNT=$(free -m | grep Mem | awk '{print $3}')
    TOTAL_RAM=$(free -m | grep Mem | awk '{print $2}')
    AVAILABLE_RAM=$(free -m | grep Mem | awk '{print $7}')
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] - Fragment Usage [$RAM_USAGE%] - Fragment Count [$RAM_COUNT MB] - Details [Total: $TOTAL_RAM MB, Available: $AVAILABLE_RAM MB]" >> "$RAM_LOG"
}

# Fungsi untuk menambahkan pencatatan penggunaan CPU ke crontab
function add_cpu_usage() {
    (crontab -l 2>/dev/null; echo "* * * * * $(realpath $0) cpu") | crontab - 
    echo "CPU usage logging added to crontab."
}

# Fungsi untuk menghapus pencatatan penggunaan CPU dari crontab
function remove_cpu_usage() {
    crontab -l | grep -v "$(realpath $0) cpu" | crontab -
    echo "CPU usage logging removed from crontab."
}

# Fungsi untuk menambahkan pencatatan penggunaan RAM ke crontab
function add_ram_usage() {
    (crontab -l 2>/dev/null; echo "* * * * * $(realpath $0) ram") | crontab -
    echo "RAM usage logging added to crontab."
}

# Fungsi untuk menghapus pencatatan penggunaan RAM dari crontab
function remove_ram_usage() {
    crontab -l | grep -v "$(realpath $0) ram" | crontab -
    echo "RAM usage logging removed from crontab."
}

# Fungsi untuk melihat cron jobs yang aktif
function view_cron_jobs() {
    echo "Active cron jobs:"
    crontab -l
}

# Menangani argumen yang diterima (untuk crontab)
if [[ "$1" == "cpu" ]]; then
    get_cpu_info
    exit 0
elif [[ "$1" == "ram" ]]; then
    get_ram_info
    exit 0
fi

# Menu utama untuk mengelola cron jobs
while true; do
    clear
    echo "===== CRONTAB MANAGER ====="
    echo "1) Add CPU usage logging"
    echo "2) Remove CPU usage logging"
    echo "3) Add RAM usage logging"
    echo "4) Remove RAM usage logging"
    echo "5) View Active Jobs"
    echo "6) Exit"
    echo "==========================="
    read -p "Choose an option: " choice

    case $choice in
        1) add_cpu_usage ;;
        2) remove_cpu_usage ;;
        3) add_ram_usage ;;
        4) remove_ram_usage ;;
        5) view_cron_jobs ;;
        6) echo "Exiting..."; exit ;;
        *) echo "Invalid option, try again!" ;;
    esac
    read -p "Press Enter to continue..."
done
