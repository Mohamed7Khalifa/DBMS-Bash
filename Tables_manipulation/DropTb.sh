#!/usr/bin/bash
read -p "Insert the table name : "  tbName
if [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9]]] ; then
    echo "enter the right name!!"
else
    if [[ -f ~/DataBase/$tbName ]] ; then
        rm ~/DataBase/$tbName
        echo "the table is droped !!"
    else
        echo "the table is not exist"
    fi
fi
