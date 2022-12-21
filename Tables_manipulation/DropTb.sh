#!/bin/bash
read -p "Please Enter your Table name: " tbName

if [[ -d ~/DataBase/$tbName ]]; then
    read -p  "Are you sure you want to delete this Table? y/n : " sure 
    case $sure in 
    [Yy]* )
        rm  ~/DataBase/$tbName 
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
