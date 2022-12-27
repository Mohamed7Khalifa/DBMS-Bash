#!/usr/bin/bash
DB_name=$1
read -p "enter table name : "  tbName
function metaData(){
    echo "You need to insert the meta data of the table "
    read -p "Insert the number of columns : " columnsNum
    while ! [[ $columnsNum = +([0-9]) ]] 
    do 
        echo'Insert valid input '
        read -p "Insert the number of columns : " columnsNum

    done
    metaData_structure='field|type|key'
    primaryKey=''
    counter=1
    while [[ $counter -le $columnsNum ]] 
        do
            echo "What is the name of column $counter : " 
            read columnName
            echo "What is the type of column $columnName : " 
                select type in int varchar
                do
                case $type in
                int )
                    columnType='int'
                    break;
                ;;
                varchar )
                    columnType='varchar'
                    break;
                ;;
                *)
                    echo 'wrong input sir!! '
                ;;
                esac
                done
            if [[ $primaryKey == '' ]] ; then
                echo "Make primary key "
                    select input in yes no
                    do
                    case $input in
                        yes)
                        primaryKey='PK'
                        metaData_structure+='\n'$columnName'|'$columnType'|'$primaryKey
                        break;
                        ;;
                        no)
                        metaData_structure+='\n'$columnName'|'$columnType'|'
                        break;
                        ;;
                        *)
                        echo 'Wrong input '
                        ;;
                        esac
                    done
            else
                metaData_structure+='\n'$columnName'|'$columnType'|'
            fi
            if [[ $counter == $columnsNum ]] ; then
                temp+=$columnName
            else
                temp+=$columnName'|'
                echo $temp
            fi
            (( counter++ ))
        done
    touch ~/DataBase/$DB_name/.$1
    echo -e $metaData_structure > ~/DataBase/$DB_name/.$1
    touch ~/DataBase/$DB_name/$1
    echo -e $temp > ~/DataBase/$DB_name/$1
    if [[ $? == 0 ]] ; then
        echo "Done XD"
        sleep 0.5 
        ./Tables_manipulation/TbMenu.sh
    else
        echo "error in creating tables "
        sleep 0.5
        ./Tables_manipulation/TbMenu.sh
    fi 
}
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do 
    echo "enter valid name!!: "
    read tbName
done

if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
        echo "the table is already created !! "
        ./main.sh
else    
        metaData $tbName
fi


