#!/bin/bash

while true; do
    # menu
    echo -e "\nPilih fitur yang ingin digunakan:"
    echo "1. Hitung jumlah buku yang dibaca oleh seseorang"
    echo "2. Hitung rata-rata durasi membaca berdasarkan perangkat"
    echo "3. Cari pembaca dengan rating tertinggi"
    echo "4. Temukan genre paling populer berdasarkan Read_Date dan Region"
    echo "5. Keluar"
    echo -n "Masukkan pilihan (1-5): "
    read pilihan

    if [ "$pilihan" -eq 1 ]; then
        # input nama
        echo -n "Masukkan nama pembaca: "
        read nama
        awk -F',' -v name="$nama" '$2 == name {count++} END {print name " membaca " count " buku."}' reading_data.csv

    elif [ "$pilihan" -eq 2 ]; then
        # Menghitung rata-rata durasi membaca berdasarkan perangkat
        echo -n "Masukkan device: "
        read device
        echo -e "\nRata-rata durasi membaca berdasarkan perangkat:"
        awk -F',' -v dev="$device" '$8 == dev {sum += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan", dev, "adalah", sum/count, "menit."; else print "Tidak ada data untuk perangkat", dev}' reading_data.csv

    elif [ "$pilihan" -eq 3 ]; then
        # Mencari pembaca dengan rating tertinggi
        awk -F',' 'NR>1 {if ($7 > max) {max=$7; name=$2; book=$3}} END {print "\nPembaca dengan rating tertinggi:", name, "-", book, "-", max}' reading_data.csv

    elif [ "$pilihan" -eq 4 ]; then
    # Menemukan genre paling populer berdasarkan Read_Date dan Region setelah 31 Desember 2023
    awk -F',' 'NR>1 && $5 > "2023-12-31" && $9 == "Asia" {
        count[$4,$9]++
    } 
    END {
        max_count = 0
        max_genre = ""
        max_region = ""
        for (key in count) {
            if (count[key] > max_count) {
                max_count = count[key]
                split(key, arr, SUBSEP)
                max_genre = arr[1]
                max_region = arr[2]
            }
        }
        print "Genre paling populer di", max_region, "setelah 2023 adalah", max_genre, "dengan", max_count, "buku."
    }' reading_data.csv


    elif [ "$pilihan" -eq 5 ]; then
        echo "Keluar dari program."
        exit 0
    
    else
        echo "Pilihan tidak valid. Silakan pilih angka 1-5."
    fi

done

