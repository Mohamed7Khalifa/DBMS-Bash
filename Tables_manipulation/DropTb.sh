#!/bin/bash
read -p "Please Enter your Table name: " tbName
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
sleep 1
if [[ -d ~/DataBase/$DB_name/$tbName ]]; then
    read -p  "Are you sure you want to delete this Table? y/n : " sure 
    case $sure in 
     Yy]* )
        rm -r ~/DataBase/$DB_name/$tbName
        rm -r ~/DataBase/$DB_name/.$tbName
        echo "Table has been deleted "
        ;;
    [Nn]* )
        echo "canceled "
        ;;
    * )
        echo "please enter y or n only "
        ;;
    esac

else 
    echo "Table doesn't exist  "
fi
