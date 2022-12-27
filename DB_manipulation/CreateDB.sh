#!/bin/bash
read -p "Please Enter your database name: " DB_name 
while [[ ! $DB_name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "Enter valid name !! "
    read DB_name
done
if [[ -d ~/DataBase/$DB_name ]]; then
    echo "The database $DB_name is already exist try diffrent name. "
    ./main.sh
else 
    mkdir -p ~/DataBase/$DB_name
    echo "Database created "
    ./main.sh
fi 