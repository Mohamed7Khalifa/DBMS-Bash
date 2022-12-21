#!/usr/bin/bash
function metaData(){
    echo "U need to insert the meta data of the table"
    read -p "insert the number of columns : " columnsNum
    if [[  ]]; then
        separator='|'
        rSeparator="\n"
        primaryKey=''
        metaData_structure='field'$separator'type'$separator'key'
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
            if [[ $primaryKey == '' ]] ; then
                echo "Make primary key [y/n]"
                    select input in y n
                    do
                        case $input in
                            y )
                            primaryKey='PK'
                            metaData_structure+=$rSeparator$columnName$separator$columnType$separator$primaryKey
                            break;
                            ;;
                            n)
                            metaData_structure+=$rSeparator$columnName$separator$columnType$separator''
                            break;
                            ;;
                            *)
                            echo 'Wrong input'
                            ;;
                        esac
                    done
            else
                metaData_structure+=$rSeparator$columnName$separator$columnType$separator''
            fi
            if [[ $counter == $columnName ]] ; then
                temp+=$columnName
            else
                temp+=$columnName$separator
                echo $temp
            fi
            (( counter++ ))
        done
        touch .$1
        echo $metaData_structure > .$1
        touch $1
        echo $temp > $1
        if [[ $? == 0 ]] ; then
            echo "Done XD"
            ./main.sh
        else
            echo "error in creating tables"
            ./main.sh
        fi
    else
        echo 'wrong input sir'
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

