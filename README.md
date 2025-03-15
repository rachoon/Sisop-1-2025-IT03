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
<img src="source/Screenshot 2025-03-15 120223.png">
<p>
  1.b) pada soal ini kita diminta untuk mencari berapa rata rata lama waktu untuk membaca pada berbagai 
  jenis device. dari sini kita dari sini kita bisa memanfaatkan `awk` untuk mencari jumlah tersebut:
</p>

```bash
read device
awk -F',' -v dev="$device" '$8 == dev {sum += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan", dev, "adalah", sum/count, "menit."; else print "Tidak ada data untuk perangkat", dev}' reading_data.csv
```

<p>nanti outputnya akan seperti ini</p>
<img src="source/Screenshot 2025-03-15 121621.png">

<p>
  1.c) pada soal ini kita diminta untuk mencari pembaca dengan ratting tertinggi disertai dengan nama, judul buku dan nilai ratting nya.
  dari sini kita dari sini kita bisa memanfaatkan `awk` untuk mencari informasi tersebut:
</p>

```bash
 awk -F',' 'NR>1 {if ($7 > max) {max=$7; name=$2; book=$3}} END {print "\nPembaca dengan rating tertinggi:", name, "-", book, "-", max}' reading_data.csv
```
<p>nanti outputnya akan seperti ini</p>
<img src="source/Screenshot 2025-03-15 122703.png">

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
<img src="source/Screenshot 2025-03-15 123131.png">



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
<img src="source/Screenshot 2025-03-15 135758.png">

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
<img src="source/Screenshot 2025-03-15 140227.png">

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
<img src="source/Screenshot 2025-03-15 141349.png">

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
<img src="source/Screenshot 2025-03-15 141730.png">

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
<img src="source/Screenshot 2025-03-15 142328.png">

<p>
    2.h) nah tadi kan kita udah buat crontab, sekarang kita akan membuat file untuk menampung data cronjobnya di core.log untuk pemantauan cpu dan fragment.log untuk pemantauan ram
</p>

<p>nanti hasil output akan seperti ini</p>
<img src="source/Screenshot 2025-03-15 142601.png">
<img src="source/Screenshot 2025-03-15 142610.png">

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
<img src="source/Screenshot 2025-03-15 142907.png">
<img src="source/Screenshot 2025-03-15 142929.png">





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
