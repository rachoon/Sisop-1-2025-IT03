# Sisop-1-2025-IT03


| Nama  | NRP |
| ------------- | ------------- |
| Zein Muhammad Hasan  | 5027241035 |
| Afriza Tristan Calendra Rajasa | 5027241104  |
| Jofanka Al-kautsar Pangestu Abady  | 5027241107  |

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
