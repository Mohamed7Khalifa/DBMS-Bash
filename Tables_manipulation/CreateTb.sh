#!/usr/bin/bash
read -p "Insert the table name : "  tbName
if [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9]]] ; then
    echo "enter the right name!!"
else
    if [[ -f ~/DataBase/$tbName ]] ; then
        echo "the database is already created !!"
    else
        echo "done!!"
        touch $tbName
    fi
fi
