#!/bin/bash
read -p "Please Enter your database name: " DB_drop_name 

if [[ -d ~/DataBase/$DB_drop_name ]]; then
    read -p  "Are you sure you want to delete this Database? y/n :" sure 
    case $sure in 
    [Yy]* )
        rm -r ~/DataBase/$DB_drop_name 
        echo "Database has been deleted "
        ;;
    [Nn]* )
        echo "canceled "
        ;;
    * )
        echo "please enter y or n only "
        ;;
    esac

else 
    echo "Database doesn't exist  "
fi