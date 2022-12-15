#!/usr/bin/bash
select input in Create_DB list_DB Connect_DB Drop_DB
do 
    case $input in 
    Create_DB )
        echo "create DB"
    ;;
    list_DB )
        echo "list DB"
    ;;
    Connect_DB )
        echo "Connect DB"
    ;;
    Drop_DB )
        echo "Drop DB"
    ;;
    *)
        echo "Wrong input"
    ;;
    esac
done
