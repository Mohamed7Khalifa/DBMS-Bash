#!/bin/bash
read -p "Please Enter your database name: " DB_name 

if [[ -d ~/DataBase/$DB_name ]]; then
    echo "The database $DB_name is already exist try diffrent name. " 

elif [[ $DB_name = "" ]]; then
    echo "please try again & enter a name "

elif [[ $DB_name = *" "* ]]; then
    echo "space are not allowed please try again  "

elif [[ $DB_name = "!" ]]; then
    echo "special character are not allowed  "

else 
    mkdir ~/DataBase/$DB_name
    echo "Database created "
fi 