#!/bin/bash

# Fungsi untuk menampilkan penggunaan RAM
tampilkan_penggunaan_ram() {
    while true; do
        clear
        echo "=============================="
        echo "   Monitor Penggunaan RAM "
        echo "=============================="
        echo "Waktu: $(date)"
        echo ""
        
        # Mengambil total dan penggunaan RAM saat ini
        TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
        USED_RAM=$(free -m | awk '/Mem:/ {print $3}')
        RAM_USAGE_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($USED_RAM/$TOTAL_RAM)*100}")
        
        echo "Total RAM: ${TOTAL_RAM} MB"
        echo "Penggunaan RAM: ${USED_RAM} MB"
        echo "Persentase Penggunaan RAM: ${RAM_USAGE_PERCENT}%"
        
        echo "=============================="
        echo "Tekan [Q] untuk kembali ke menu"
        read -n 1 -s INPUT
        if [[ "$INPUT" == "q" || "$INPUT" == "Q" ]]; then
            break
        fi
    done
}

tampilkan_penggunaan_ram
