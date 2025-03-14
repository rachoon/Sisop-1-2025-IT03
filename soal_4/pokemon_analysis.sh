#!/bin/bash
file=$1
command=$2
column=$3

# --logo
function logo()
{
  echo "                                                                                           "
  echo "                                                                                           "
  echo "                                                                  *@@@@@@@@@@@@@  ******   "
  echo "                                                                  *@@@@@@@@@@@@@  ******   "
  echo "                                                @@@               *@@@@@@@@@@@@@ :******   "
  echo "            @@@@@@@@@@            %%%:          @@@               *@@@@@@@@@@@@@: ******   "
  echo "            @@@@@@@@@@@@      % :********       @@@               =...... @@@@@@           "
  echo "            @@@@     @@@@   %    **********     @@@     @@@@@     =****** @@@@@@           "
  echo "            @@@@     @@@@  ***=*****#%##****    @@@    @@@@       =****** @@@@@@           "
  echo "            @@@@   @@@@@   ***######-  :##**    @@@  @@@@         =****** @@@@@@           "
  echo "            @@@@@@@@@@@    %##%:   #%::#%###*   @@@ @@@@          =****** @@@@@@           "
  echo "            @@@@           #+               .   @@@@@@@@@         =****** @@@@@@           "
  echo "            @@@@            ++            ..    @@@   @@@@        =****** @@@@@@           "
  echo "            @@@@             %+++       ++      @@@    @@@@@      =****** @@@@@@           "
  echo "            @@@@                @+++++%         @@@      @@@@     =****** @@@@@@           "
  echo "                                                                  =****** @@@@@@           "
  echo "                                                                  =****** ######           "
  echo "                                                                                           "
  echo "                                                                                           "
}
# --help
function show_help()
{
  logo
  echo -e "Selamat datang di PokIT!"
  echo -e "\nCara menggunakan: $0 $file [options]"
  echo -e "Contoh: ./pokemon_analysis.sh pokemon_usage.csv --sort usage\n"
  echo -e "\nSilakan pilih"
  echo -e "--info \t\t\t\t Memunculkan pokemon dengan usage dan rawUsage tertinggi."
  echo -e "--sort <coloumn> \t\t Menyortir data sesuai list di bawah."
  echo -e "   pokemon \t\t\t Sort berdasarkan pokemon."
  echo -e "   usage \t\t\t Sort berdasarkan usage."
  echo -e "   rawusage \t\t\t Sort berdasarkan rawusage."
  echo -e "   type1 \t\t\t Sort berdasarkan type1."
  echo -e "   type2 \t\t\t Sort berdasarkan type2."
  echo -e "   hp \t\t\t\t Sort berdasarkan hp."
  echo -e "   atk \t\t\t\t Sort berdasarkan atk."
  echo -e "   def \t\t\t\t Sort berdasarkan def."
  echo -e "   spatk \t\t\t Sort berdasarkan spatk."
  echo -e "   spdef \t\t\t Sort berdasarkan spdef."
  echo -e "   speed \t\t\t Sort berdasarkan speed.\n"
  echo -e "--grep \t\t\t\t Mencari kata berdasarkan nama pokemon."
  echo -e "-- filter <type> \t\t Mencari filter berdasarkan type."
  echo -e "-h, --help \t\t\t Untuk bantuan."
  exit 1
  
}

# --info
function show_info()
{
  awk -F "," '
  BEGIN {usage="no_usage"; usage_num=0; rawusage="now_rawusage"; rawusage_num=0} 
  # Untuk sorting usage
  {if ($2 >= usage_num && NR>=2) usage_num = $2; usage=$1} 
  
  # Untuk sorting RawUsage
  {if ($3 >= rawusage_num && NR>=2) rawusage_num = $3; rawusage = $1} 
  END { print " User dengan usage paling tinggi = ", usage, "dengan", usage_num,"\n", "User dengan RawUsage tertinggi =", rawusage, "dengan", rawusage_num}' $file
}

# --sort
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

# --grep
function search_pokemon()
{
  file=$1
  name=$2
  grep -i "^$name," $file
}

# jalankan program tanpa menggunakan --help
if [ $# -lt 2 ]; then 
  show_help
fi

# error check
if [ ! -f "$file" ]; then 
  echo "Maaf, $file tidak ditemukan." 
  show_help 
  exit 1
fi

function type_filter()
{
  file=$1
  search=$2
  # untuk case insensitive
  awk -F, -v search="$search" 'tolower($4) == tolower(search) || tolower($5) == tolower(search)' $file | sort -k1
  
  # untuk case sensitive
  # awk -F, -v search="$search" '$4 == search || $5 == search' $file
}

case $command in
  "--help")
    show_help
    ;;
  "--info")
    show_info
    ;;
  "--sort")
  if [ -z "$column" ]; then 
      echo "Input yang anda masukkan salah" 
      exit 1
  fi
    show_sort
    ;;

  "--grep")
  if [ $# -lt 3 ]; then 
    echo "Kata yang anda cari tidak dimasukkan. Coba lagi"
    exit 1
  fi
    search_pokemon $file $3
  ;;
  "--filter")
    if [ $# -lt 3 ]; then 
    echo "Kata yang anda cari tidak dimasukkan. Coba lagi"
    exit 1
  fi
  type_filter $file $3
  ;;


  *)
    echo "Perintah $command tidak tersedia."
    show_help
    exit 1
    ;;
esac
