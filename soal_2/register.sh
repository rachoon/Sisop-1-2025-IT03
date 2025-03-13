# #!/bin/bash

DATABASE="./data/player.csv"
STATIC_SALT="Salt123"  # Static salt untuk hashing

# Pastikan parameter lengkap
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <email> <username> <password>"
    exit 1
fi

EMAIL="$1"
USERNAME="$2"
PASSWORD="$3"

# Validasi format email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Error: Format email tidak valid!"
    exit 1
fi

if grep -q "^$EMAIL," "$DATABASE"; then
    echo "Error: Email sudah terdaftar!"
    exit 1
fi

# Validasi password (minimal 8 karakter, 1 huruf besar, 1 huruf kecil, 1 angka)
if [[ "${#PASSWORD}" -lt 8 ]]; then
    echo "Error: Password harus memiliki minimal 8 karakter!"
    exit 1
fi
if ! [[ "$PASSWORD" =~ [a-z] ]]; then
    echo "Error: Password harus mengandung setidaknya satu huruf kecil!"
    exit 1
fi
if ! [[ "$PASSWORD" =~ [A-Z] ]]; then
    echo "Error: Password harus mengandung setidaknya satu huruf besar!"
    exit 1
fi
if ! [[ "$PASSWORD" =~ [0-9] ]]; then
    echo "Error: Password harus mengandung setidaknya satu angka!"
    exit 1
fi


# Hash password dengan SHA-256 dan static salt
HASHED_PASSWORD=$(echo -n "$PASSWORD$STATIC_SALT" | sha256sum | awk '{print $1}')

# Simpan data ke file CSV
echo "$EMAIL,$USERNAME,$HASHED_PASSWORD" >> "$DATABASE"
echo "User berhasil didaftarkan!"
