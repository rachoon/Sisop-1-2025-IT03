# #!/bin/bash

DATABASE="./data/player.csv"
STATIC_SALT="Salt123"  # static salt untuk hashing password

# parameter register
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <email> <username> <password>"
    exit 1
fi

EMAIL="$1"
USERNAME="$2"
PASSWORD="$3"

# validasi email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "ERROR: Format email tidak valid!"
    exit 1
fi

if grep -q "^$EMAIL," "$DATABASE"; then
    echo "ERROR: Email sudah terdaftar!"
    exit 1
fi

# validasi password
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


# hashing password dengan SHA-256 dan static salt
HASHED_PASSWORD=$(echo -n "$PASSWORD$STATIC_SALT" | sha256sum | awk '{print $1}')

# simpan data ke database
echo "$EMAIL,$USERNAME,$HASHED_PASSWORD" >> "$DATABASE"
echo "User berhasil didaftarkan!"
