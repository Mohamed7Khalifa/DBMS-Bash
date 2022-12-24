#!/usr/bin/bash
DB_name=$1
echo 'insert the table name XD: '
read tbName
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
     echo $field
     awk -v column=$field '
        BEGIN{
            FS="|"
        }
        {
            print "|",$column,"|"
        }
     ' ~/DataBase/$DB_name/$tbName
}
echo "choose the type of select u want " 
select input in Select_All Select_column Select_with_Condition
do
    case $input in
    Select_All ) 
        Select_All 
    ;;
  Select_column )
        echo 'enter the name of column'
        read columnName 
        Select_column $columnName
    ;;
    Select_with_Condition )
        read -p 'enter ur condition value : ' targetValue
        sed -n '/$targetValue/p' ~/DataBase/$DB_name/$tbName
    ;;
    * )
        echo "Wrong input"
        ./Tables_manipulation/Select.sh
    ;;
    esac 
done