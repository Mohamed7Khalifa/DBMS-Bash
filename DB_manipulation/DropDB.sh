#!/bin/bash
read -p "Please Enter your database name: " DB_drop_name 
while [[ ! $DB_drop_name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "enter valid name!!"
    read DB_name
done
if [[ -d ~/DataBase/$DB_drop_name ]]; then
    read -p  "Are you sure you want to delete this Database? y/n : " sure 
    case $sure in 
    [Yy]* )
        rm -r ~/DataBase/$DB_drop_name 
        echo "Database has been deleted "
        ;;
    [Nn]* )
        echo "canceled "
        ;;
    * )
        echo "Please enter y or n only "
        ;;
    esac

else 
    echo "Database doesn't exist  "
fi