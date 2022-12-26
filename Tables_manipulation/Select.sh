#!/usr/bin/bash
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
sleep 1
echo 'insert the table name XD: '
read tbName
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
        else
            awk -v column=$field '
            BEGIN{
                FS="|"
            }
            {
                print "|",$column,"|"
            }
        ' ~/DataBase/$DB_name/$tbName
        sleep 1
        fi
        
    }
    function Select_with_Condition(){
        targetColumn=$1
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
        else
            targetValue=$2
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
            else
                echo 'the record = '
                echo $values
                sleep 1
            fi
        fi
    }
    echo "choose the type of select u want " 
    select input in Select_All Select_column Select_with_Condition
    do
        case $input in
        Select_All ) 
            Select_All 
        ;;
    Select_column )
            read -p 'enter the name of column : ' columnName 
            Select_column $columnName
        ;;
        Select_with_Condition )
            read -p 'enter the condition column : ' targetColumn
            read -p 'enter the conition value : ' targetValue
            Select_with_Condition $targetColumn $targetValue
            # sed -n '/$targetValue/p' ~/DataBase/$DB_name/$tbName
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