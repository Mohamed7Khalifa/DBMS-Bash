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
     fi
     
}
Select_with_Condition(){
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
    targetValue=$2
    awk -v column=$field -v target="$targetValue" '
        BEGIN{
            FS="|"
        }
        { 
            print "------"
            print $column
            
            if( $column == target ){
                print $column
            }
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