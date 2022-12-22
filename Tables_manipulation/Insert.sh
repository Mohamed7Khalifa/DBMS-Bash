#!/usr/bin/bash
echo 'insert the table name XD: '
read tbName
while [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9] ]]
do
    echo 'invalid input X('
    echo 'Enter valid input : '
    read tbName
done
if [[ -f ~/DataBase/$1/$tbName ]] ; then
    awk -f | '
    {
        
    }
    ' ~/DataBase/$1/$tbName

else
    echo 'sorry this table is not exist X('
    echo "Do u wanna create table"
    select input in yes no
    do
        case $input in 
            yes)
            ./Tables_manipulation/CreateTb.sh $1
            ;;
            no)
            ./Tables_manipulation/TbMenu.sh
            ;;
            *)
            echo "wrong input X( "
            ;;
            esac
    done

fi