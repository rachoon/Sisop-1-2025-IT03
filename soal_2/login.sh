#!/bin/bash

DATABASE="./data/player.csv"
STATIC_SALT="Salt123"  # Static salt yang sama seperti di register.sh

# parameter login
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <email> <password>"
    exit 1
fi

EMAIL="$1"
PASSWORD="$2"

# validasi email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Error: Format email tidak valid!"
    exit 1
fi

# mengecek data email di database
USER_DATA=$(grep "^$EMAIL," "$DATABASE")
if [ -z "$USER_DATA" ]; then
    echo "Error: Email tidak terdaftar!"
    exit 1
fi

# hashing passwordd dari database
STORED_PASSWORD=$(echo "$USER_DATA" | cut -d',' -f3)

# hasing ulang password yang diinput untuk dibandingkan dengan data yang ada di database
HASHED_INPUT_PASSWORD=$(echo -n "$PASSWORD$STATIC_SALT" | sha256sum | awk '{print $1}')

# mencocokan hashing dari password
if [ "$HASHED_INPUT_PASSWORD" != "$STORED_PASSWORD" ]; then
    echo "Error: Password salah!"
    exit 1
fi

echo "Login berhasil!"
