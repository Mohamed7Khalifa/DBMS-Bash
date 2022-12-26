#!/bin/bash
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
read -p "Please Enter your Table name: " tbName
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "enter valid name!!"
    read tbName
done
if [[ -f ~/DataBase/$DB_name/$tbName ]]; then
    read -p  "Are you sure you want to delete this Table? y/n : " sure 
    case $sure in 
     [Yy]* )
        rm -r ~/DataBase/$DB_name/$tbName
        rm -r ~/DataBase/$DB_name/.$tbName
        echo "Table has been deleted "
        ./Tables_manipulation/TbMenu.sh

        ;;
    [Nn]* )
        echo "canceled "
        ./Tables_manipulation/TbMenu.sh

        ;;
    * )
        echo "please enter y or n only "
        ;;
    esac

else 
    echo "Table doesn't exist  "
fi
