#!/bin/bash
read -p "Please Enter your database name: " DB_name 

if [[ -d ~/DataBase/$DB_name ]]; then
    read "Are you sure you want to delete this Database? y/n" sure 
    if [[ $sure=y ]] ; then
    rm -r $DB_name
    echo "The database $DB_name is deleted  "
    else 
        echo "okay"
    fi 

else 
    echo "write the right db name "
fi