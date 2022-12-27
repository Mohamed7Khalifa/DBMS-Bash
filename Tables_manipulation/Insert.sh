#!/usr/bin/bash
clear
DB_name=$1
echo "-Inset Values-"
echo "The available Tables are: "
echo "---------------------------------"
ls -F ./DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
echo 'Insert the table name : '
read tbName
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "enter valid name!!"
    read tbName
done
if [[ -f ./DataBase/$DB_name/$tbName ]] ; then
    columnsNum=`awk '
        BEGIN{
            FS="|"
        }
        END{
            print NR
        }
        ' ./DataBase/$1/.$tbName`
    # echo $columnsNum
    counter=2
    while [[ $counter -le $columnsNum ]]
    do
        columnName=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $1
        }
        ' ./DataBase/$1/.$tbName`
        columnType=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $2
        }
        ' ./DataBase/$1/.$tbName`
        columnKey=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $3
        }
        ' ./DataBase/$1/.$tbName`
        # echo $columnName
        # echo $columnType
        # echo $columnKey
        read -p "Enter value of $columnName ($columnType) = "  input
        while ! [[  $columnType = "int" && $input = +([0-9]) ||  $columnType = "varchar" &&  $input = +([a-zA-Z0-9])  ]]
            do
                echo "Enter valid value !! "
                read -p "Enter value of $columnName ($columnType) = "  input

            done
        if [[ $counter == $columnsNum ]] ; then
            echo $input >> ./DataBase/$DB_name/$tbName
        else
            echo -n $input'|' >> ./DataBase/$DB_name/$tbName 
        fi
        (( counter++ ))
    done
    if [[ $? == 0 ]] ; then
        echo "Data Inserted Successfully "
        sleep 0.5
        ./Tables_manipulation/TbMenu.sh
    else
        echo "Error Inserting Data into Table $tbName "
        sleep 0.5
        ./Tables_manipulation/TbMenu.sh 
    fi

else
    echo 'Sorry this table is not exist. '
    echo "Do you want to  create table"
    select input in yes no
    do
        case $input in 
            yes)
            ./Tables_manipulation/CreateTb.sh $DB_name
            ;;
            no)
            ./Tables_manipulation/TbMenu.sh
            ;;
            *)
            echo "Wrong input!! "
            ;;
            esac
    done

fi