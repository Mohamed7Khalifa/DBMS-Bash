#!/usr/bin/bash
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$1/ | grep -v "/"
echo "---------------------------------"
sleep 1
echo "Enter the name u want to delete"
read tbName
if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
    echo "Do u wanna delete all or specific row"
    select input in Delete_ALL Delete_Row
    do
        case $input in
        Delete_ALL )
            sed -i '1,$d' ~/DataBase/$DB_name/$tbName
            echo 'delete all done Successfully!!'
            ./Tables_manipulation/TbMenu.sh 
        ;;
        Delete_Row )
            read -p 'enter ur ur condition value : ' targetValue
            sed -i '1!{/$targetValue/d;}' ~/DataBase/$DB_name/$tbName
            echo 'Done X)) '
            ./Tables_manipulation/TbMenu.sh 
        ;;
        *)
            echo 'wrong input sir!!'
        ;;
        esac
    done 
else
    echo 'this table is not exists'
    ./Tables_manipulation/TbMenu.sh 

fi