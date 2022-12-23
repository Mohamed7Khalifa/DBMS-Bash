#!/usr/bin/bash
function metaData(){
    echo "U need to insert the meta data of the table"
    read -p "insert the number of columns : " columnsNum
    while [[ $columnsNum != [0-9] || $columnsNum != *[0-9] ]] 
    do 
        read -p 'insert valid input' columnsNum
    done
    metaData_structure='field|type|key'
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
                echo 'wrong input sir!!'
                esac
                done
            if [[ $counter == 1 ]] ; then
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
                        echo 'Wrong input'
                        ;;
                        esac
                    done
            else
                metaData_structure+='\n'$columnName'|'$columnType'|'
            fi
            if [[ $counter == $columnName ]] ; then
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
        ./main.sh
    else
        echo "error in creating tables"
        ./main.sh
    fi 
}
DB_name=$1
echo $DB_name
read -p "enter table name : "  tbName
if [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9] ]] ; then
    echo "enter the right name!!"
    ./Tables_manipulation/CreateTb.sh
else
    if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
        echo "the table is already created !!"
        ./main.sh
    else    
        metaData $tbName
    fi
fi

