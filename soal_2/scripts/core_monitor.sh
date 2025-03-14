#!/bin/bash

# Fungsi untuk menampilkan penggunaan CPU
tampilkan_penggunaan_cpu() {
    CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^ *//')
    while true; do
        clear
        echo "=============================="
        echo "   Monitor Penggunaan CPU "
        echo "=============================="
        echo "Waktu: $(date)"
        echo ""
        echo "Jenis CPU: $CPU_MODEL"
        
        # Mengambil penggunaan CPU dalam persen
        CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
        echo "Penggunaan CPU: $CPU_USAGE%"
        
        echo "=============================="
        echo "Tekan [Q] untuk kembali ke menu"
        read -n 1 -s INPUT
        if [[ "$INPUT" == "q" || "$INPUT" == "Q" ]]; then
            break
        fi
    done
}

tampilkan_penggunaan_cpu
