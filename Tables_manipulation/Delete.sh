#!/usr/bin/bash
clear
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ./DataBase/$1/ | grep -v "/"
echo "---------------------------------"
sleep 1
echo "Enter the name u want to delete"
read tbName
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "Enter valid name !! "
    read tbName
done
function deleteRow(){
    echo "This is the where section "
        read -p 'Enter the condition column : ' targetColumn
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
            echo "Your column isn't found "
            sleep 0.5
            ./Tables_manipulation/TbMenu.sh
        else
            read -p 'Enter the conition value : ' targetValue
            targetLine=$(awk -v column=$field -v target="$targetValue" '
            BEGIN{
                FS="|"
            }
            { 
                if (column!=1){
                if( $column == target ){
                    printf NR
                    exit
                }
                }
            }
            ' ./DataBase/$DB_name/$tbName)
            if [[ $targetLine = '' ]] ; then
                echo "Your condition isn't found"
                sleep 0.5
                ./Tables_manipulation/TbMenu.sh
            else
                # echo $targetLine
                sed -i -e"${targetLine}d" ./DataBase/$DB_name/$tbName
                echo "Done "
                sleep 2
            fi
        fi
}
if [[ -f ./DataBase/$DB_name/$tbName ]] ; then
    echo "Do you want to delete all or specific row "
    select input in Delete_ALL Delete_Row
    do
        case $input in
        Delete_ALL )
            sed -i '2,$d' ./DataBase/$DB_name/$tbName
            echo 'Delete all done Successfully!! '
            sleep 0.5
            ./Tables_manipulation/TbMenu.sh 
        ;;
        Delete_Row )
            deleteRow
            sleep 0.5
            ./Tables_manipulation/TbMenu.sh 
        ;;
        *)
            echo 'wrong input sir !! '
        ;;
        esac
    done 
else
    echo 'This table is not exists '
    ./Tables_manipulation/TbMenu.sh 

fi