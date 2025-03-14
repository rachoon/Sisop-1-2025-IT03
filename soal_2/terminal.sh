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
