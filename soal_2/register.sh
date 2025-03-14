#!/bin/bash

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

# Validasi email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "ERROR: Format email tidak valid!"
    exit 1
fi

if grep -q "^$EMAIL," "$DATABASE"; then
    echo "ERROR: Email sudah terdaftar!"
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

# Hashing password dengan SHA-256 dan static salt
HASHED_PASSWORD=$(echo -n "$PASSWORD$STATIC_SALT" | sha256sum | awk '{print $1}')

# Menyimpan data ke database
echo "$EMAIL,$USERNAME,$HASHED_PASSWORD" >> "$DATABASE"
echo "User berhasil didaftarkan!"
