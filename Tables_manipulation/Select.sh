#!/usr/bin/bash
clear
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"

echo 'insert the table name XD: '
read tbName
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "enter valid name!!"
    read tbName
done
if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
    function Select_All(){
        awk '{
            print $0
        }' ~/DataBase/$DB_name/.$tbName
    }
    function Select_column(){
        targetValue=$1
        field=`awk -v var="$targetValue" '
            BEGIN{
                FS="|"
            }
            {
                for(i=1;i<=NF;i++){
                    if($i==var){
                        print i
                    }
                }
            }
        ' ~/DataBase/$DB_name/$tbName`
        if [[ $field = '' ]] ; then
                echo "Ur column is not found"
                ./Tables_manipulation/TbMenu.sh
        else
            awk -v column=$field '
            BEGIN{
                FS="|"
            }
            {
                print "|",$column,"|"
            }
        ' ~/DataBase/$DB_name/$tbName
        ./Tables_manipulation/TbMenu.sh
        sleep 1
        fi
    }
    function Select_with_Condition(){
        # targetColumn=$1
        read -p 'enter the condition column : ' targetColumn
        field=`awk -v var="$targetColumn" '
            BEGIN{
                FS="|"
            }
            {
                for(i=1;i<=NF;i++){
                    if($i==var){
                        print i
                    }
                }
            }
        ' ~/DataBase/$DB_name/$tbName`
        if [[ $field = '' ]] ; then
                echo "Ur column is not found"
                ./Tables_manipulation/TbMenu.sh
        else
            # targetValue=$2
            read -p 'enter the conition value : ' targetValue
            values=`awk -v column=$field -v target="$targetValue" '
            BEGIN{
                FS="|"
            }
            { 
                if( $column == target ){
                    print $0
                }
            }
            ' ~/DataBase/$DB_name/$tbName`
            if [[ $values = '' ]] ; then
                echo "Ur condition value is not found"
                ./Tables_manipulation/TbMenu.sh

            else
                echo 'the record = '
                sed -n "1p" ~/DataBase/$DB_name/$tbName
                echo $values
                ./Tables_manipulation/TbMenu.sh
                sleep 1
            fi
        fi
    }
    function Select_Column_with_Condition(){
        # targetColumn=$1
        read -p 'enter the output column name : ' targetColumn
        field=`awk -v var="$targetColumn" '
            BEGIN{
                FS="|"
            }
            {
                for(i=1;i<=NF;i++){
                    if($i==var){
                        print i
                    }
                }
            }
        ' ~/DataBase/$DB_name/$tbName` 
        if [[ $field = '' ]] ; then
                echo "Ur column is not found"
                ./Tables_manipulation/TbMenu.sh
        else
            read -p "enter the condition column " column
            read -p 'enter the condition value : ' targetValue 

            values=`grep -w $targetValue ~/DataBase/$DB_name/$tbName | cut -d "|" -f$field`

            if [[ $values = '' ]] ; then
                echo "Ur condition value is not found"
                ./Tables_manipulation/TbMenu.sh

            else
                # echo 'the record = '
                sed -n "1p" ~/DataBase/$DB_name/$tbName | cut -d "|" -f$field
                echo $values
                ./Tables_manipulation/TbMenu.sh
                sleep 1
            fi
        fi
    }
    echo "choose the type of select u want " 
    select input in Select_All Select_column Select_Record_with_Condition Select_Column_with_Condition
    do
        case $input in
        Select_All ) 
            Select_All
        ./Tables_manipulation/TbMenu.sh
             
        ;;
        Select_column )
            read -p 'enter the name of column : ' columnName 
            Select_column $columnName
        ;;
        Select_Record_with_Condition )
            Select_with_Condition 
            # sed -n '/$targetValue/p' ~/DataBase/$DB_name/$tbName
        ;;
        Select_Column_with_Condition )
            Select_Column_with_Condition
        ;;
        * )
            echo "Wrong input"
            ./Tables_manipulation/Select.sh
        ;;
        esac 
    done
else
    echo 'the table is not exists X('
    sleep 2
    ./Tables_manipulation/TbMenu.sh
    
fi