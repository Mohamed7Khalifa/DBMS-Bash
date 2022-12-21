#!/usr/bin/bash
function metaData(){
    echo "U need to insert the meta data of the table"
    read -p "insert the number of columns : " columnsNum
    while [[ $columnsNum =~ [0-9] || $columnsNum =~ *[0-9] ]] 
    do 
        read -p 'insert valid input' columnsNum
    done
    primaryKey=''
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
                echo "Make primary key [y/n]"
                    select input in y n
                    do
                        case $input in
                            y )
                            primaryKey='PK'
                            metaData_structure+='\n'$columnName'|'$columnType'|'$primaryKey
                            break;
                            ;;
                            n)
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
    touch .$1
    echo -e $metaData_structure > .$1
    touch -e $1
    echo $temp > $1
    if [[ $? == 0 ]] ; then
        echo "Done XD"
        ./main.sh
    else
        echo "error in creating tables"
        ./main.sh
    fi
   
    
}

read -p "Insert the table name : "  tbName
if [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9] ]] ; then
    echo "enter the right name!!"
    ./Tables_manipulation/CreateTb.sh
else
    if [[ -f ~/DataBase/$tbName ]] ; then
        echo "the database is already created !!"
    else    
        metaData $tbName
    fi
fi

