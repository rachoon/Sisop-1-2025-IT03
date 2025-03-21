#!/bin/bash

speak_to_me() {
    echo "Menjalankan Speak to Me..."

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color

    clear

    read -p "Masukkan durasi script berjalan (dalam detik): " duration

    if ! [[ "$duration" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Masukkan angka yang valid.${NC}"
        exit 1
    fi

    start_time=$(date +%s)
    while [ $(($(date +%s) - start_time)) -lt $duration ]; do
        
        affirmation=$(curl -s -H "Accept: application/json" "https://www.affirmations.dev" | jq -r '.affirmation')
        
        colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN")
        color=${colors[$RANDOM % ${#colors[@]}]}
        
        echo -e "${color}$affirmation${NC}"
  
        sleep 1
    done

    echo -e "${GREEN}Selesai! Terima kasih telah menggunakan script ini.${NC}"
}

# Fungsi untuk menjalankan program "On the Run"
on_the_run() {
    echo "Menjalankan On the Run..."

    clear

    GREEN='\033[0;32m'
    NC='\033[0m' # Reset warna

    
    PROGRESS=0

    # menampilkan progress bar
    draw_progress_bar() {
        BAR_LENGTH=$(tput cols)-8
        local filled=$((PROGRESS * BAR_LENGTH / 100))
        local empty=$((BAR_LENGTH - filled))

        BAR="["
        for ((i = 0; i < filled; i++)); do
            BAR+="${GREEN}#${NC}"
        done
        for ((i = 0; i < empty; i++)); do
            BAR+=" "
        done
        BAR+="]"

        echo -ne "\r${BAR} ${PROGRESS}%"
    }

    # Loop utama
    while [ $PROGRESS -lt 100 ]; do
        # Tampilkan progress bar
        draw_progress_bar

        # Tentukan pesan status
        if [ $PROGRESS -lt 50 ]; then
            MESSAGE="sabar wir"
        elif [ $PROGRESS -lt 100 ]; then
            MESSAGE="dikit lagi bre"
        else
            MESSAGE="done yagesyaaaaa"
        fi

        tput el  # Hapus baris sebelumnya
        echo -e "\n${MESSAGE}"

        # Random delay (0.1 - 1 detik)
        sleep 0.$((RANDOM % 10))
        clear

        # Increment progress (acak antara 1-10)
        PROGRESS=$((PROGRESS + RANDOM % 10))
        if [ $PROGRESS -gt 100 ]; then
            PROGRESS=100
        fi

        # Geser kursor ke atas untuk menimpa pesan status sebelumnya
        tput cuu 2
    done

    # Tampilkan progress bar dan pesan final saat selesai
    draw_progress_bar
    tput el  # Hapus baris sebelumnya
    MESSAGE="done yagesyaaaaa"  # Pastikan pesan status diperbarui
    echo -e "\n${GREEN}${MESSAGE}${NC}"
}

# Fungsi untuk menjalankan program "Time and Date"
Time() {
    echo "Menjalankan Time..."
    clear

    while true; do
        # Ambil tanggal dan waktu saat ini
        current_date=$(date +"%A, %d %B %Y")
        current_time=$(date +"%T")

        clear
        echo -e "\033[1;32mTanggal:\033[0m $current_date"
        echo -e "\033[1;34mWaktu :\033[0m $current_time"

        # Tunggu 1 detik sebelum memperbarui
        sleep 1
    done
}

# Fungsi untuk menampilkan efek "Money" seperti hujan kelip-kelip
Money() {
    echo "Menjalankan Money..."

    clear

    currencies=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")

    # Warna teks
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    PURPLE='\033[0;35m'
    NC='\033[0m' # No Color

    # Inisialisasi array untuk menyimpan posisi dan kecepatan setiap kolom
    declare -a positions
    declare -a speeds

    # Jumlah kolom (sesuaikan dengan lebar terminal)
    cols=$(tput cols)
    rows=$(tput lines)

    # Inisialisasi posisi dan kecepatan awal untuk setiap kolom
    for ((i = 0; i < cols; i++)); do
        positions[$i]=$((RANDOM % rows))  # Posisi awal acak
        speeds[$i]=$((RANDOM % 3 + 1))    # Kecepatan acak (1-3)
    done

    # Loop utama
    while true; do
        clear

        # Tampilkan simbol mata uang untuk setiap kolom
        for ((i = 0; i < cols; i++)); do
        
            currency=${currencies[$RANDOM % ${#currencies[@]}]}

            colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN" "$PURPLE")
            color=${colors[$RANDOM % ${#colors[@]}]}

        
            tput cup ${positions[$i]} $i
            echo -ne "${color}${currency}${NC}"

            # Update posisi untuk efek jatuh
            positions[$i]=$((positions[$i] + 1))

            # Jika posisi melebihi jumlah baris, reset ke atas
            if [ ${positions[$i]} -ge $rows ]; then
                positions[$i]=0
            fi
        done

        
        sleep 0.1
    done
}

Brain_Damage() {
    echo "Menjalankan Brain Damage..."

    clear
    
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    PURPLE='\033[0;35m'
    NC='\033[0m' # No Color

    # Loop untuk memperbarui daftar proses setiap detik
    while true; do
        clear

        # Header
        echo -e "${PURPLE}PID     USER       CPU%   MEM%   COMMAND${NC}"
        echo "-------------------------------------------"

        # Ambil daftar proses dan tampilkan dengan warna acak setiap barisnya
        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11 | while read -r line; do
            # Pilih warna acak
            colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN" "$PURPLE")
            color=${colors[$RANDOM % ${#colors[@]}]}

            # Tampilkan baris dengan warna
            echo -e "${color}${line}${NC}"
        done

        sleep 1
    done
}


if [ $# -lt 1 ]; then
    echo "Usage: ./dsotm.sh --play=<program_name>"
    exit 1
fi

for arg in "$@"; do
    case "$arg" in
        (--play="Speak to Me")
            speak_to_me
            ;;
        (--play="On the Run")
            on_the_run
            ;;
        (--play="Time")
            Time
            ;;
        (--play="Money")
            Money
            ;;
        (--play="Brain Damage")
            Brain_Damage
        (*)
            echo "Program tidak dikenal: $arg"
            exit 1
            ;;
    esac
done
