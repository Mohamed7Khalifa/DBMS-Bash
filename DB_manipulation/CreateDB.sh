#!/bin/bash
read -p "Please Enter your database name: " DB_name 
while [[ $DB_name =~ [' '] || $DB_name =~ ['./|\+_&^%$#@!~"'] || $DB_name =~ [0-9] ]]
do
    echo "plz Enter valid name "
    read DB_name 
done
if [[ -d ~/DataBase/$DB_name ]]; then
    echo "The database $DB_name is already exist try diffrent name. " 
else 
    mkdir -p ~/DataBase/$DB_name
    echo "Database created "
fi 