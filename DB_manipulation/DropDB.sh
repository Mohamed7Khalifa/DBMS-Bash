#!/bin/bash
read -p "Please Enter your database name: " DB_name 

if [[ -d ~/DataBase/$DB_name ]]; then
    
    rm -r $DB_name
    echo "The database $DB_name is deleted  "

else 
    echo "write the right db name "
fi