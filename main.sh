#!/usr/bin/bash
echo "Hint if u want to close the program press Cntrl+c X) "
sleep 2
echo "Choose what u want sir!!"
select input in Create_DB list_DB Connect_DB Drop_DB
do 
    case $input in 
    Create_DB )
        echo "create DB"
        ./DB_manipulation/CreateDB.sh
    ;;
    list_DB )
        echo "list DB"
        ./DB_manipulation/ListDB.sh
    ;;
    Drop_DB )
        echo "Drop DB"
        ./DB_manipulation/DropDB.sh
    ;;
    Connect_DB )
        echo "Connect DB"
        ./Tables_manipulation/TbMenu.sh 
    ;;
    *)
        echo "Wrong input"
        echo " "
        ./main.sh
    ;;
    esac
done