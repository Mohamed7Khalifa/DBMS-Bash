#!/usr/bin/bash
echo 'insert the table name XD: '
read tbName
function Select_All(){
    awk '{
        print $0
    }' ~/DataBase/$1/.$tbName
}
function Select_column(){
    
}
# function Select_with_Condition(){}
DB_name=$1
echo "choose the type of select u want " 
select input in Select_All Select_column Select_with_Condition
do
    case $input in
    Select_All ) 
        Select_All $DB_name
    ;;
    Select_column ) 
    
    ;;
    Select_with_Condition )

    ;;
    * )
        echo "Wrong input"
        ./Tables_manipulation/Select.sh
    ;;
    esac 
done