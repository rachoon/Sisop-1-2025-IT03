# Sisop-1-2025-IT03


| Nama  | NRP |
| ------------- | ------------- |
| Zein Muhammad Hasan  | 5027241035 |
| Afriza Tristan Calendra Rajasa | 5027241104  |
| Jofanka Al-kautsar Pangestu Abady  | 5027241107  |

<h1>penjelasan dan laporan modul_1</h1>
<hr />
<h2>soal 1</h2>
<p>
  pada soal satu kita diminta membuat sebuah program untuk mengolah suatu
  database dari csv dengan bantuan awk
</p>
<p>
  1.a) pada soal ini kita diminta untuk mencari berapa banyak buku yang dibaca
  seseorang, dalam soal diminta Chris Hemsworth, dari sini kita bisa
  memanfaatkan `awk` untuk mencari jumlah tersebut:
</p>

```bash
read nama
awk -F',' -v name="$nama" '$2 == name {count++} END {print name " membaca " count " buku."}' reading_data.csv
```
<p>dan nanti outputnya akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/f84e6dd1-c176-4c73-a141-238e3063629e">
<p>
  1.b) pada soal ini kita diminta untuk mencari berapa rata rata lama waktu untuk membaca pada berbagai 
  jenis device. dari sini kita dari sini kita bisa memanfaatkan `awk` untuk mencari jumlah tersebut:
</p>

```bash
read device
awk -F',' -v dev="$device" '$8 == dev {sum += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan", dev, "adalah", sum/count, "menit."; else print "Tidak ada data untuk perangkat", dev}' reading_data.csv
```

<p>nanti outputnya akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/1481a6eb-71c4-49a2-b01d-9af3236301b8">

<p>
  1.c) pada soal ini kita diminta untuk mencari pembaca dengan ratting tertinggi disertai dengan nama, judul buku dan nilai ratting nya.
  dari sini kita dari sini kita bisa memanfaatkan `awk` untuk mencari informasi tersebut:
</p>

```bash
 awk -F',' 'NR>1 {if ($7 > max) {max=$7; name=$2; book=$3}} END {print "\nPembaca dengan rating tertinggi:", name, "-", book, "-", max}' reading_data.csv
```
<p>nanti outputnya akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/c5183d0c-6bfd-4e31-a4f1-a5f04dfc7f7f">

<p>
  1.d) pada soal ini kita diminta untuk mencari genre buku yang paling populer setelah 2023 dan di regoin asia.
  dari sini kita dari sini kita bisa memanfaatkan `awk` untuk mencari informasi tersebut:
</p>

```bash
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
```
<p>nanti outputnya akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/2aa8cf78-4973-48d4-86bf-26017f083641">



<h2>soal_2</h2>
<p>pada soal kali ini kita diminta untuk membuat beberapa script yang nanti akan saling berhubungan satu sama lain.
    soal ini membutuhkan pengetahuan tentang pemrograman pembuatan akun cara login hingga fitur fitur yang ada didalamnya.
</p>
<p>
    2.a) pada soal ini kita diminta untuk membuat sebuah script yang berfungsi sebagai wadah membuat user dan sebuah script untuk login user tersebut
    dan tidak lupa data akan disimpan di database basis csv.
</p>

```bash
DATABASE="./data/player.csv"
STATIC_SALT="Salt123"  # static salt untuk hashing password

# Meminta input dari pengguna
echo -n "Masukkan email: "
read EMAIL
echo -n "Masukkan nama: "
read USERNAME
echo -n "Masukkan password: "
read -s PASSWORD  # Input password secara tersembunyi
echo ""
```
<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/31e5e884-235a-4102-ab00-86fdf2d8e711">

<p>
    2.b) pada soal ini kita diminta untuk membuat validasi pada email agar harus memiliki karakter @ dan . , serta validasi password 
    harus memiliki setidaknya 8 karakter dengan wajib ada minimal 1 huruf kecil, huruf besar, dan nomor.
</p>

```bash
# Validasi email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "ERROR: Format email tidak valid!"
    exit 1
fi


# Validasi password
if [[ "${#PASSWORD}" -lt 8 ]]; then
    echo "ERROR: Password harus memiliki minimal 8 karakter!" 
    exit 1
fi
if ! [[ "$PASSWORD" =~ [a-z] ]]; then
    echo "ERROR: Password setidaknya ada satu huruf kecil!"
    exit 1
fi
if ! [[ "$PASSWORD" =~ [A-Z] ]]; then
    echo "ERROR: Password setidaknya ada satu huruf kapital!"
    exit 1
fi
if ! [[ "$PASSWORD" =~ [0-9] ]]; then
    echo "ERROR: Password harus mengandung setidaknya satu angka!"
    exit 1
fi
```

<p>
    2.c) pada soal ini kita diminta untuk membuat fitur untuk mengecek ke unikan sebuah email, jadi setiap user tidak akan memiliki email yang sama.
</p>

```bash
if grep -q "^$EMAIL," "$DATABASE"; then
    echo "ERROR: Email sudah terdaftar!"
    exit 1
fi
```
<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/ee5e6d46-f2d4-4d9a-83b0-3e9b8ba9c612">

<p>
    2.d) pada soal ini kita diminta untuk membuat password yang perlu disimpan dalam bentuk yang tidak mudah diakses.
     dan mengunakan algoritma hashing sha256sum yang memakai static salt. 
</p>

```bash
# Hashing password dengan SHA-256 dan static salt
HASHED_PASSWORD=$(echo -n "$PASSWORD$STATIC_SALT" | sha256sum | awk '{print $1}')
```

<p>
    2.e) pada soal ini kita diminta untuk membuat fitur pemantauan CPU dalam persen dan juga menampilkan jenis CPU yang digunkan.
</p>

```bash
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "Penggunaan CPU: $CPU_USAGE%"
CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^ *//')
echo "Jenis CPU: $CPU_MODEL"
```
<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/892e2dfe-7f7c-457b-b08a-abbf2e9a09e8">

<p>
    2.f) pada soal ini kita diminta untuk membuat fitur pemantauan RAM dalam persen dan juga menampilkan jumlah RAM yang digunkan sekarang.
</p>

```bash
# Mengambil total dan penggunaan RAM saat ini
        TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
        USED_RAM=$(free -m | awk '/Mem:/ {print $3}')
        RAM_USAGE_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($USED_RAM/$TOTAL_RAM)*100}")
        
        echo "Total RAM: ${TOTAL_RAM} MB"
        echo "Penggunaan RAM: ${USED_RAM} MB"
        echo "Persentase Penggunaan RAM: ${RAM_USAGE_PERCENT}%"
```
<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/88f7713e-ec38-487d-8203-f695126752d4">

<p>
    2.g) pada soal ini kita diminta untuk membuat fitur crontab, jadi nanti pemantauan CPU dan RAM nya bisa outomatis tergantung kita mau setiap berapa lama.
</p>

```bash
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
```
<p>intinya pada kode ini kami mmebuat beberapa fitur yang ada pada crontab, yaitu menyalakan/add cronjob untuk cpu dan ram serta menonaktifkan/remove. 
   tidak lupa kita juga membuat fitur yang bisa melihat cronjob apa yang sedang berjalan.
</p>

<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/e42608e7-1db8-43e1-88f7-50d237763c47">

<p>
    2.h) nah tadi kan kita udah buat crontab, sekarang kita akan membuat file untuk menampung data cronjobnya di core.log untuk pemantauan cpu dan fragment.log untuk pemantauan ram
</p>

<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/a7eb2943-fbda-4ee2-a55d-8c562f841706">
<img src="https://github.com/user-attachments/assets/b5764938-8fa8-4768-9277-714c0944c504">

<p>
    2.i) pada soal ini kita diminta untuk membuat terminal yang menjadi jendela utama untuk user dan komputer(ui yang membungkus
     semua script tadi).
</p>

```bash
#!/bin/bash

while true; do
    clear
    echo "=============================="
    echo "      Terminal Dashboard      "
    echo "=============================="
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    echo "=============================="
    echo -n "Pilih menu: "
    read MENU

    case $MENU in
        1)
            ./register.sh
            read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali ke menu..."
            ;;
        2)
            ./login.sh
            if [ $? -eq 0 ]; then
                while true; do
                    clear
                    echo "=============================="
                    echo "      User Dashboard      "
                    echo "=============================="
                    echo "1. Tampilkan Penggunaan CPU"
		    echo "2. Tampilkan Penggunaan RAM"
		    echo "3. Crontab manager"
                    echo "4. Logout"
                    echo "=============================="
                    echo -n "Pilih menu: "
                    read USER_MENU

                    case $USER_MENU in
                        1)
                            ./scripts/core_monitor.sh
                            ;;
			2)
			    ./scripts/frag_monitor.sh
                            ;;
			3)
			    ./scripts/manager.sh
			    ;;
			4)
                            break
                            ;;
                        *)
                            echo "Pilihan tidak valid!"
                            sleep 1
                            ;;
                    esac
                done
            fi
            ;;
        3)
            echo "Keluar..."
            exit 0
            ;;
        *)
            echo "Pilihan tidak valid!"
            sleep 1
            ;;
    esac

done
```

<p>nanti hasil output akan seperti ini</p>
<img src="https://github.com/user-attachments/assets/e69ea1c4-b886-4a97-9c0c-fed2898fadf6">
<img src="https://github.com/user-attachments/assets/fa9e7fbf-57c4-4cdd-a0ac-eee88e8e9460">



## soal_3

### A. Fungsi ```Speak to Me```

Untuk menjalankan fungsi tersebut, pengguna diminta untuk memasukkan berapa lama fungsi ini berjalan (dalam detik).
```
read -p "Masukkan durasi script berjalan (dalam detik): " duration
```
Setelah itu, fungsi akan menjalankan afirmasi. Tetapi sebelum itu diperlukan best case dengan kode sebagai berikut.
```
    if ! [[ "$duration" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Masukkan angka yang valid.${NC}"
        exit 1
    fi
```
Dimana kode ini mengecek apakah input durasi berupa angka. Jika input bukan merupakan angka, maka akan muncul pesan berwarna merah yaitu ```Masukkan angka yang valid.```. Untuk fungsi ```{NC}``` sendiri merupakan fungsi untuk mereset warna agar warna teks dapat digunakan kembali.
Contoh output-nya sebagai berikut.

![Image](https://github.com/user-attachments/assets/ca9b44f2-2a67-4c53-9175-c9ff67e201cf)

Jika inputnya berupa angka (dalam detik) maka fungsi afirmasi akan berjalan sebagai berikut.
```
    start_time=$(date +%s)
    while [ $(($(date +%s) - start_time)) -lt $duration ]; do
        # Mengambil afirmasi dari API
        affirmation=$(curl -s -H "Accept: application/json" "https://www.affirmations.dev" | jq -r '.affirmation')
        
        # Memilih warna acak
        colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN")
        color=${colors[$RANDOM % ${#colors[@]}]}
        
        # Menampilkan afirmasi dengan warna
        echo -e "${color}$affirmation${NC}"
        
        # Tunggu 1 detik
        sleep 1
    done

    echo -e "${GREEN}Selesai! Terima kasih telah menggunakan script ini.${NC}"
```
Jika fungsi ini dijalankan, maka outputnya sebagai berikut.

![Image](https://github.com/user-attachments/assets/f2525c4b-0972-4378-ac3a-3ea4d126f05a)


### B. Fungsi ```On the Run```

Untuk menjalankan fungsi tersebut, pada awalnya diperlukan sebuah kode yang bernama ```clear``` untuk menghapus isi terminal tersebut. Setelah itu, fungsi akan menginisialisasi warna teks (dalam fungsi tersebut menggunakan warna ASCII hijau ```\033[0;32m``` dan reset color ```\033[0m```. Lalu fungsi akan menginialisasi variabel awal berupa ```BAR_LENGTH=30``` dan ```PROGRESS=0```.
Setelah itu, fungsi ```draw_progress_bar()``` dijalankan untuk mencetak setiap proses per seratus persen.
```
    draw_progress_bar() {
        local filled=$((PROGRESS * BAR_LENGTH / 100))
        local empty=$((BAR_LENGTH - filled))

        # Buat progress bar
        BAR="["
        for ((i = 0; i < filled; i++)); do
            BAR+="${GREEN}#${NC}"
        done
        for ((i = 0; i < empty; i++)); do
            BAR+=" "
        done
        BAR+="]"

        # Tampilkan progress bar dan persentase
        echo -ne "\r${BAR} ${PROGRESS}%"
    }
```

Fungsi ```draw_progress_bar``` digunakan untuk dipanggil oleh fungsi while di bawah.
```
    while [ $PROGRESS -lt 100 ]; do
        # Tampilkan progress bar
        draw_progress_bar

        # Tentukan pesan status
        if [ $PROGRESS -lt 50 ]; then
            MESSAGE="sabar wir"
        elif [ $PROGRESS -lt 100 ]; then
            MESSAGE="dikit lagi bre"
        else
            MESSAGE="done yagesya"
        fi

        # Tampilkan pesan status di bawah progress bar
        tput el  # Hapus baris sebelumnya
        echo -e "\n${MESSAGE}"

        # Random delay (0.1 - 1 detik)
        sleep 0.$((RANDOM % 10))

        # Increment progress (acak antara 1-10)
        PROGRESS=$((PROGRESS + RANDOM % 10))
        if [ $PROGRESS -gt 100 ]; then
            PROGRESS=100
        fi

        # Geser kursor ke atas untuk menimpa pesan status sebelumnya
        tput cuu 2
    done
```
Untuk dapat menampilkan keseluruhan proses, kode di bawah diperlukan sebagai berikut.
```
    draw_progress_bar
    tput el  # Hapus baris sebelumnya
    MESSAGE="done yagesya"  # Pastikan pesan status diperbarui
    echo -e "\n${GREEN}${MESSAGE}${NC}"
```
Contoh outputnya seperti ini

https://github.com/user-attachments/assets/196b1fd6-6af9-429d-a0fc-7da511ed1af3

### C. Fungsi ```Time and Date```
Ketika fungsi ini dijalankan, akan muncul sebuah tampilan kapan tanggak dan waktu untuk saat ini. Untuk kodenya seperti ini

```
    echo "Menjalankan Time and Date..."

    # Membersihkan terminal WSL
    clear

    # Loop untuk memperbarui tanggal dan waktu setiap detik
    while true; do
        # Ambil tanggal dan waktu saat ini
        current_date=$(date +"%A, %d %B %Y")
        current_time=$(date +"%T")

        # Bersihkan terminal dan tampilkan tanggal dan waktu
        clear
        echo -e "\033[1;32mTanggal:\033[0m $current_date"
        echo -e "\033[1;34mWaktu :\033[0m $current_time"

        # Tunggu 1 detik sebelum memperbarui
        sleep 1
    done
```
Sebelum fungsi dijalankan, terminal harus dibersihkan dulu dengan mengguanakn ```clear```, lalu fungsi akan melakukan perulangan while dan mengupdate setiap detiknya menggunakan ```sleep 1```.
Untuk outputnya seperti ini. Untuk menghentikan proses, cukup tekan ```ctrl + c``` pada keyboard.

https://github.com/user-attachments/assets/79b272f4-1328-470d-aa30-1b0108b82a1b
### D. Fungsi ```Money```
FUngsi ini diawali dengan ```clear``` lalu dilakuakn beberapa inisialisasi, seperti warna, posisi, kecepatan, colom dan baris. Untuk kodenya sebagai berikut
```
    clear

    # Daftar simbol mata uang
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
```
Setelah itu, fungsi while dijalankan dengan inisialisasi yang sudah dibuat sebelumnya.
```
    while true; do
        # Bersihkan layar
        clear

        # Tampilkan simbol mata uang untuk setiap kolom
        for ((i = 0; i < cols; i++)); do
            # Pilih simbol mata uang acak
            currency=${currencies[$RANDOM % ${#currencies[@]}]}

            # Pilih warna acak
            colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN" "$PURPLE")
            color=${colors[$RANDOM % ${#colors[@]}]}

            # Tampilkan simbol mata uang di posisi yang sesuai
            tput cup ${positions[$i]} $i
            echo -ne "${color}${currency}${NC}"

            # Update posisi untuk efek jatuh
            positions[$i]=$((positions[$i] + 1))

            # Jika posisi melebihi jumlah baris, reset ke atas
            if [ ${positions[$i]} -ge $rows ]; then
                positions[$i]=0
            fi
        done

        # Tunggu sebentar sebelum memperbarui
        sleep 0.1
    done
```
Untuk output-nya sebagai berikut. Untuk menghentikan proses ini cukup tekan ```ctrl + c``` pada keyboard.

https://github.com/user-attachments/assets/c5e9a45b-11b7-4e0a-96a9-1a144c963f95

### E. Fungsi ```Brain Damage```
Untuk fungsi ini diawali dengan ```clear```, lalu inisialisasi warna teks sebagai berikut.
```
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    PURPLE='\033[0;35m'
    NC='\033[0m
```
Setelah itu, fungsi while dijalankan dengan update setiap detiknya. Untuk kodenya seperti ini
```
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

        # Tunggu 1 detik sebelum update
        sleep 1
    done
```
Dimana pada ```ps -eo``` fungsi akan memanggil data berupa ```pid,user,%cpu,%mem,%comm```. Lalu untuk funggi ```head -n 11``` berfungsi untuk menampilkan output header + 10 baris proses terbesar. Untuk menghentikan proses ini cukup tekan ```ctrl + c``` pada keyboard.
Untuk output-nya sebagai berikut.

https://github.com/user-attachments/assets/d17ff3da-4beb-494f-9402-da47eea20dbc

### F. Best case
Untuk best case akan menggunakan kode sebagai berikut.
```
if [ $# -lt 1 ]; then
    echo "Usage: ./dsotm.sh --play=<program_name>"
    exit 1
fi
```
Untuk outputnya sebagai berikut.
![Image](https://github.com/user-attachments/assets/3805dd50-8c4b-470a-92f2-13d31f1a1354)

G. Argumen Utama
Untuk fungsi ini, kode diperlukan sebagai berikut/
```
for arg in "$@"; do
    case "$arg" in
        (--play="Speak to Me")
            speak_to_me
            ;;
        (--play="On the Run")
            on_the_run
            ;;
        (--play="Time and Date")
            time_and_date
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
```
Dimana setiap input yang kita masukkan akan masuk ke salah satu list sesuai input. Contoh: ```./dsotm.sh --play="Speak to Me"```. Jika input yang dijalankan berbeda dari kode di atas, maka muncul teks ```Program tidak dikenal: $arg``` dimana ```$arg``` merupakan argumen yang di-input oleh user.

## Soal_4

### A. Variabel Input
Dalam membaca input user, diperlukan sebuah inisialisasi variabel dengan format sebagai berikut.
```
$0 $1 $2 $3
```
dimana

1. ```$0``` Merupakan kode eksekusi program, seperti  ```./pokemon_analysis.sh```

2. ```$1``` Merupakan kode nama file, seperti ```pokemon_usage.csv```.
3. ```$2``` Merupakan kode untuk menjalankan sebuah fungsi, seperti ```--info```, ```--help``` dan alin sebagainya.
4. ```$3``` Merupakan kode untuk menjalankan fungsi tambahan, sebagai contoh pada fungsi ```--grep``` diperlukan fungsi tambahan, contohnya ```usage```

sehingga contoh penggunaan command sebagai berikut.
```
./pokemon_analysis.sh pokemon_usage.csv --grep usage
```


### B. Fungsi ```--help``` atau ```-h```
Fungsi ini untuk mencetak sebuah tampilan yang memudahkan user untuk mengetahui bagaimana cara menggunakan file tersebut.


### C. Fungsi ```--info```
Fungsi ```--info``` berfungsi untuk memberikan informasi berupa pokemon dengan usage dan RawUsage tertinggi.
```
  awk -F "," '
  BEGIN {usage="no_usage"; usage_num=0; rawusage="now_rawusage"; rawusage_num=0} 
  # Untuk sorting usage
  {if ($2 >= usage_num && NR>=2) usage_num = $2; usage=$1} 
  
  # Untuk sorting RawUsage
  {if ($3 >= rawusage_num && NR>=2) rawusage_num = $3; rawusage = $1} 
  END { print " User dengan usage paling tinggi = ", usage, "dengan", usage_num,"\n", "User dengan RawUsage tertinggi =", rawusage, "dengan", rawusage_num}' $file
```
dimana
1. ```BEGIN{...}``` untuk setting variabel awal, yaitu pokemon dan usage/rawUsage.
2. Fungsi dibawah ini untuk mencari data maksimum.
   ```
   {if ($2 >= usage_num && NR>=2) usage_num = $2; usage=$1}
   ```
   Dalam fungsi tersebut, jika jumlah bilangan pada kolom 2 ```$2``` melebihi atau sama dengan ```usage_num```, dan baris yang dituju lebih dari 2 (```NR>=2```) maka data tersebut menjadi data maksimum, begitu pula dengan rawUsage.

3. Untuk fungsi awk ```END{...}``` digunakan untuk mencetak output hasil akumulasi.


### D. Fungsi ```--sort```
Fungsi ini digunakan untuk menyortir data berdasarkan kolom tertentu.
```
function show_sort()
{
  head -n 1 "$file"
  case $column in
    ("pokemon") tail -n +2 "$file" | sort -t, -k1,1 -nr ;;
    ("usage") tail -n +2 "$file" | sort -t, -k2,2 -nr ;;
    ("rawusage") tail -n +2 "$file" | sort -t, -k3,3 -nr ;;
    ("type1") tail -n +2 "$file" | sort -t, -k4,4 -nr ;;
    ("type2") tail -n +2 "$file" | sort -t, -k5,5 -nr ;;
    ("hp") tail -n +2 "$file" | sort -t, -k6,6 -nr ;;
    ("atk") tail -n +2 "$file" | sort -t, -k7,7 -nr ;;
    ("def") tail -n +2 "$file" | sort -t, -k8,8 -nr ;;
    ("spatk") tail -n +2 "$file" | sort -t, -k9,9 -nr ;;
    ("spdef") tail -n +2 "$file" | sort -t, -k10,10 -nr ;;
    ("speed") tail -n +2 "$file" | sort -t, -k11,11 -nr ;;
    (*) echo "Input $column tidak ditemukan."
      echo "Input yang tersedia: pokemon, usage, rawusage, type1, type2, hp, atk, def, spatk, spdef, speed." ;;
  esac
}
```
1. Untuk fungsi ```head -n 1 "$file"``` digunakan untuk mencetak header dari sebuah data.
   
2. Untuk kode ini
   ```
   case $column in
    ("pokemon") tail -n +2 "$file" | sort -t, -k1,1 -nr ;;
    ..
    (*) echo "Input $column tidak ditemukan."
      echo "Input yang tersedia: pokemon, usage, rawusage, type1, type2, hp, atk, def, spatk, spdef, speed." ;;
   esac
   ```
  dimana:
  
  A. ```case $column in``` untuk mengambil data user berupa column
  
  B. ```("pokemon")``` merupakan penyortiran data berdasarkan nama.
  
  C. ```tail -n +2 "$file"``` merupakan pencetakan data dari ```$file```, dengan +2 agar data header tidak ikut dicetak. 
  
  D. ```| sort -t, -k1,1 -nr``` merupakan penyortiran dengan: ```-t,``` jeda menggunakan tanda koma, ```-k1,1``` merupakan penyortiran berdasarkan kolom pertama, dan ```-nr``` merupakan penyortiran data dilakukan secara descemnding.


### E. Fungsi ```--grep```
Untuk fungsi berikut
```
function search_pokemon()
{
  file=$1
  name=$2
  grep -i "^$name," $file
}

```
dimana:
1. ```file=$1``` merupakan inisialisasi file csv.
  
2. ```name=$2``` merupakan inisialisasi nama pokemon yang akan dicari.
   
3. ```grep -i "^$name," $file``` merupakan pencarian denan ```-i``` sebagai case-insensitive (tidak membedakan huruf besar/kecil).

### F. Fungsi ```-f``` dan ```--filter```
```
function type_filter()
{
  file=$1
  search=$2
  # untuk case insensitive
  awk -F, -v search="$search" 'tolower($4) == tolower(search) || tolower($5) == tolower(search)' $file | sort -k1
  
  # untuk case sensitive
  # awk -F, -v search="$search" '$4 == search || $5 == search' $file
}
 ```
1. ```file=$1``` merupakan inisialiasi file csv.
2. ```search=$2``` merupakan inisialisasi pencarian yang diinginkan.
3. ```awk -F,``` merupakan fungsi awk dengan koma sebagai pemisah.
4. ``` -v search="$search"``` merupakan fungsi agar mengambil sebuah variabel dari shell dan dimasukkan ke dalam fungsi awk.
5. ```'tolower($4) == tolower(search) || tolower($5) == tolower(search)'``` merupakan fungsi jika type yang dicari ada pada kolom 4 atau 5 secara case-insensitive.
6. ```sort -k1``` merupakan penyortiran berdasarkan nama pokemon.


### G. Fungsi ```case $command in```
1. Fungsi ```"-h"|"--help"```
   ```
     "-h"|"--help")
    show_help
    ;;
   ```
   Dari salah satu fungsi merupakan jika input user ```-h``` atau ```--help``` maka akan menjalankan fungsi ```show_help```.

2. Fungsi ```--sort```
    ```
     "--sort")
    if [ -z "$column" ]; then 
      echo "Input yang anda masukkan salah" 
      exit 1
    fi
      show_sort
    ;;
   ```
   Untuk fungsi ```--sort``` pada ```if [ -z "$column" ];``` merupakan case dimana jika input ```$column``` tidak ada, maka muncul pesan ```"Input yang anda masukkan salah"```, jika tidak maka akan menjalankan fungsi ```show_sort```.

3. Fungsi ```--grep```
   ```
     "--grep")
    if [ $# -lt 3 ]; then 
      echo "Kata yang anda cari tidak dimasukkan. Coba lagi"
      exit 1
    fi
       search_pokemon $file $3
    ;
   ```
   pada fungsi ```--grep```, jika input kurang dari 3, misal ```./pokemon_analysis.sh pokemon_usage.csv --grep``` maka muncul pesan ```Kata yang anda cari tidak dimasukkan. Coba lagi```, jika tidak akan menjalankan fungsi ```search_pokemon``` dengan input ```$file``` sebagai ```$1``` dan ```$3``` sebagi ```$2```.


### Revisi Soal_4

Revisi dari soal ini mencakup:
1. Perbaikan pada ```--info```, dimana sebelumnya menampilkan data yang salah sudah diperbaiki. Untuk kodenya sebagai berikut.
   Usage
   ![Screenshot 2025-03-20 232918](https://github.com/user-attachments/assets/3eee5ea3-001e-4c94-a850-ce83f91faed7)
   rawUsage
   ![Screenshot 2025-03-20 232934](https://github.com/user-attachments/assets/2820e1cc-873f-4742-8692-47661a479a17)
   dimana untuk filter raw, mula-mula tanda ```%``` dihilangkan terlebih dahulu, setelah disort, program akan mencetak ```%``` secara manual. Untuk rawUsage, tanda lebih dari sama dengan diganti menjadi lebih dari. Untuk outputnya seperti ini
   
   ![Screenshot 2025-03-21 065028](https://github.com/user-attachments/assets/1927dc13-5adf-4184-a0d7-1d3d5e7cf5c9)

2. Perbaikan pada ```--sort```
   Perbaikan ini dibuat agar jika pengguna memasukkan input yang tidak sesuai, maka header tidak ikut ditampilkan. Untuk kodenya sebagai berikut
   ![Screenshot 2025-03-20 232951](https://github.com/user-attachments/assets/a7f9a24c-bba3-4666-ac3c-1524aebea1cf)
   Untuk outputnya sebagai berikut
   
   Sebelum

   ![Screenshot 2025-03-21 065737](https://github.com/user-attachments/assets/c76850c3-09a1-4a2a-ab55-36a62bc608aa)
   Sesudah

   ![Screenshot 2025-03-21 065659](https://github.com/user-attachments/assets/132afd72-bdb5-4c0c-941a-5f8184b30281)

3. Perbaikan pada ```--grep```
   Untuk perbaikan ini, terdapat perubahan sistem ```--grep```, dimana sebelumnya menggunakan sort secara langsung, sehingga perbaikan ini menggunakan awk dan sorting berdasarkan kolom usage. Untuk kodenya seperti ini
   
   ![Black and Green Circle Gradient Sass Startup Pricing Plan Presentation](https://github.com/user-attachments/assets/dec824a2-5a5a-41ba-96cf-3b33206798ed)
   Untuk ouputnya seperti ini
   
   ![Screenshot 2025-03-21 070616](https://github.com/user-attachments/assets/a8d65339-cbb7-4a2c-98ca-4697c1536b0a)
