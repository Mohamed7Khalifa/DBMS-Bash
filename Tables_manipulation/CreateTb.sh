#!/usr/bin/bash
read -p "Insert the table name : "  tbName
if [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9]]] ; then
    echo "enter the right name!!"
else
    if [[ -f ~/DataBase/$tbName ]] ; then
        echo "the database is already created !!"
    else    
        touch $tbName
        echo "done!!"
    fi
fi
function metaData(){
    echo "U need to insert the meta data of the table"
    read -p "insert the number of columns : " columnsNum
    separator='|'
    rSeparator='\n'
    primaryKey=''
    metaData_structure='field'$separator'type'$separator'key'
    counter=1
    while[[ $counter < $columnsNum ]] 
    do
        read -p "What is the name of column $columnsNum" $columnName
        echo "What is the type of column $columnsName" 
        select type in int varchar
        do
        case $type in
        int )
        columnType='int'
        ;;
        varchar )
        columnType='varchar'
        ;;
        *)
        echo 'wrong input sir!!'
        esac
        done

        # echo -e "What is the name of column $columnsNum"

    done


}
