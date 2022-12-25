#!/usr/bin/bash
DB_name=$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
sleep 1
echo 'insert the table name XD: '
read tbName

while [[ $tbName =~ [' '] || $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9] ]]
do
    echo 'invalid input X('
    echo 'Enter valid input : '
    read tbName
done
if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
    columnsNum=`awk '
        BEGIN{
            FS="|"
        }
        END{
            print NR
        }
        ' ~/DataBase/$1/.$tbName`
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
        ' ~/DataBase/$1/.$tbName`
    columnType=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $2
        }
        ' ~/DataBase/$1/.$tbName`
    columnKey=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $3
        }
        ' ~/DataBase/$1/.$tbName`
    # echo $columnName
    # echo $columnType
    # echo $columnKey
    while [[ true ]]
    do
        read -p "Enter value of $columnName ($columnType) = "  input
        if [[ columnType='int' && $input = +([0-9]) || columnType='varchar' && $input = +([a-zA-Z0-9]) ]] ;then
            if [[ $counter == $columnsNum ]] ; then
                echo $input >> ~/DataBase/$1/$tbName
            else
                echo -n $input'|' >> ~/DataBase/$1/$tbName 
            fi
            break
        else
            echo "enter valid value X( "
        fi
    done
    # echo -e "\n" >> ~/DataBase/$1/$tbName
    (( counter++ ))
    done
    if [[ $? == 0 ]] ; then
        echo "Data Inserted Successfully"
        ./main.sh
    else
        echo "Error Inserting Data into Table $tbName"
        ./Tables_manipulation/TbMenu.sh 
    fi

else
    echo 'sorry this table is not exist X('
    echo "Do u wanna create table"
    select input in yes no
    do
        case $input in 
            yes)
            ./Tables_manipulation/CreateTb.sh $1
            ;;
            no)
            ./Tables_manipulation/TbMenu.sh
            ;;
            *)
            echo "wrong input X( "
            ;;
            esac
    done

fi