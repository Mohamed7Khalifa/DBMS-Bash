#!/usr/bin/bash
clear
echo "-Select-"
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ./DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"

echo 'Insert the table name: '
read tbName
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "Enter valid name!! "
    read tbName
done
if [[ -f ./DataBase/$DB_name/$tbName ]] ; then
    function Select_All(){
        awk '{
            print $0
        }' ./DataBase/$DB_name/$tbName
        sleep 2
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
        ' ./DataBase/$DB_name/$tbName`
        if [[ $field = '' ]] ; then
                echo "Your column isn't found "
                ./Tables_manipulation/TbMenu.sh
        else
            awk -v column=$field '
            BEGIN{
                FS="|"
            }
            {
                print "|",$column,"|"
            }
        ' ./DataBase/$DB_name/$tbName
        sleep 2
        ./Tables_manipulation/TbMenu.sh
        fi
    }
    function Select_All_with_Condition(){
        # targetColumn=$1
        read -p 'Enter the condition column: ' targetColumn
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
        ' ./DataBase/$DB_name/$tbName`
        if [[ $field = '' ]] ; then
                echo "Your column is not found "
                sleep 2 
                ./Tables_manipulation/TbMenu.sh
        else
            # targetValue=$2
            read -p 'Enter the conition value: ' targetValue
            values=`awk -v column=$field -v target="$targetValue" '
            BEGIN{
                FS="|"
            }
            { 
                if( $column == target ){
                    print $0
                }
            }
            ' ./DataBase/$DB_name/$tbName`
            if [[ $values = '' ]] ; then
                echo "Your condition value isn't found"
                sleep 2 
                ./Tables_manipulation/TbMenu.sh

            else
                echo 'the record = '
                sed -n "1p" ./DataBase/$DB_name/$tbName
                echo $values
                sleep 2
                ./Tables_manipulation/TbMenu.sh
            fi
        fi
    }
    function Select_Column_with_Condition(){
        # targetColumn=$1
        read -p 'Enter the output column name: ' targetColumn
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
        ' ./DataBase/$DB_name/$tbName` 
        if [[ $field = '' ]] ; then
                echo "Your column is not found "
                sleep 2
                ./Tables_manipulation/TbMenu.sh
        else
            read -p "Enter the condition column " column
            read -p 'Enter the condition value: ' targetValue 

            values=`grep -w $targetValue ./DataBase/$DB_name/$tbName | cut -d "|" -f$field`

            if [[ $values = '' ]] ; then
                echo "Your condition value is not found "
                sleep 2
                ./Tables_manipulation/TbMenu.sh

            else
                echo 'The record = '
                sed -n "1p" ./DataBase/$DB_name/$tbName | cut -d "|" -f$field
                echo $values
                sleep 2
                ./Tables_manipulation/TbMenu.sh
            fi
        fi
    }
    echo "Choose the type of select you want " 
    select input in Select_All Select_column Select_All_with_Condition Select_Column_with_Condition
    do
        case $input in
        Select_All ) 
            Select_All
            
        ./Tables_manipulation/TbMenu.sh
             
        ;;
        Select_column )
            read -p 'Enter the name of column : ' columnName 
            Select_column $columnName
        ;;
        Select_All_with_Condition )
            Select_All_with_Condition 
        ;;
        Select_Column_with_Condition )
            Select_Column_with_Condition
        ;;
        * )
            echo "Wrong input "
            ./Tables_manipulation/Select.sh
        ;;
        esac 
    done
else
    echo "The table isn't exists. "
    sleep 2
    ./Tables_manipulation/TbMenu.sh
    
fi