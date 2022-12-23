#!/usr/bin/bash
DB_name=$1
echo "Enter the name u want to delete"
read tbName
if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
    columnsNum=`awk '
        BEGIN{
            FS="|"
        }
        END{
            print NR
        }
        ' ~/DataBase/$1/.$tbName`
    rm -r ~/DataBase/$DB_name/$tbName
    echo 'Delete is done Successfully'
    ./Tables_manipulation/TbMenu.sh 
else
    echo 'this table is not exists'
    ./Tables_manipulation/TbMenu.sh 

fi