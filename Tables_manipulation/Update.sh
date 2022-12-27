DB_name=$1
clear
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$DB_name/ | grep -v "/"
echo "---------------------------------"
sleep 0.5
read -p "type the table name XD " tbName
function getRecord(){
        echo "this is the where section"
        read -p 'enter the condition column : ' targetColumn
        field=`awk -v targetColumn="$targetColumn" '
            BEGIN{
                FS="|"
            }
            {
                for(i=1;i<=NF;i++){
                    if($i==targetColumn){
                        print i
                    }
                }
            }
        ' ~/DataBase/$DB_name/$tbName`
        if [[ $field = '' ]] ; then
            echo "Ur column is not found"
            sleep 0.5
            ./Tables_manipulation/TbMenu.sh
        else
            read -p 'enter the conition value : ' targetValue
            targetLine=$(awk -v column=$field -v target="$targetValue" '
            BEGIN{
                FS="|"
                
            }
            { 
                if( $column == target ){
                    printf NR
                    exit
                }
            }
            ' ~/DataBase/$DB_name/$tbName)
            if [[ $targetLine = '' ]] ; then
                echo "Ur condition is not found"
                ./Tables_manipulation/TbMenu.sh
            else
                insertRecord
                echo $targetLine
                sed -i "${targetLine} d" ~/DataBase/$DB_name/$tbName
                echo "done"
                sleep 0.5
                ./Tables_manipulation/TbMenu.sh
            fi
        fi
}
function insertRecord(){
    columnsNum=`awk '
        BEGIN{
            FS="|"
        }
        END{
            print NR
        }
        ' ~/DataBase/$DB_name/.$tbName`
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
        ' ~/DataBase/$DB_name/.$tbName`
        columnType=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $2
        }
        ' ~/DataBase/$DB_name/.$tbName`
        columnKey=`awk '
        BEGIN{
            FS="|"
        }
        {
            if(NR=='$counter') print $3
        }
        ' ~/DataBase/$DB_name/.$tbName`
    while [[ true ]]
        do
            read -p "Enter value of $columnName ($columnType) = "  input
            if [[ $columnType = 'int' && $input =~ +([0-9]) || $columnType = 'varchar' && $input = +([a-zA-Z0-9]) ]] ;then
                if [[ $counter == $columnsNum ]] ; then
                    echo $input >> ~/DataBase/$DB_name/$tbName
                else
                    echo -n $input'|' >> ~/DataBase/$DB_name/$tbName 
                fi
                break
            else
                echo "enter valid value X( "
            fi
        done
        (( counter++ ))
    done
    if [[ $? == 0 ]] ; then
        echo "Data Inserted Successfully"
    else
        echo "Error Inserting Data into Table $tbName"
        sleep 0.5
        ./Tables_manipulation/TbMenu.sh 
    fi
}
while [[ ! $tbName =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do 
    echo "enter valid name!!"
    read tbName
done
if [[ -f ~/DataBase/$DB_name/$tbName ]] ; then
    getRecord
else
    echo "this table is not exist X( "
    sleep 0.5
    ./Tables_manipulation/TbMenu.sh
fi