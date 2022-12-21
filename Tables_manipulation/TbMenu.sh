#!/usr/bin/bash
read -p "Insert the table name : "  DB_name

while [[ $DB_name =~ [' '] || $DB_name =~ ['!@#$%^&*()_+'] || $DB_name =~ [0-9] ]]
do 
    read -p "enter valid name X( " DB_name
done

if [[ -d ~/DataBase/$DB_name ]] ; then
    select input in Create_Tb list_Tb Drop_Tb Insert_Tb Delete_Tb Select_TB Update_Tb
    do 
            case $input in 
            Create_Tb )
                echo "Create_Tb"
                ./Tables_manipulation/CreateTb.sh
            ;;
            list_Tb )
                echo "list_Tb"
                ./Tables_manipulation/ListTb.sh
            ;;
            Drop_Tb )
                echo "Drop_Tb"
                ./Tables_manipulation/DropTb.sh
            ;;
            Insert_Tb )
                echo "Insert_Tb"
                ./Tables_manipulation/Insert.sh
            ;;
            Delete_Tb )
                echo "Delete_Tb"
                ./Tables_manipulation/Delete.sh  
            ;;
            Select_TB )
                echo "Select_TB"
                ./Tables_manipulation/Select.sh
            ;;
            Update_Tb )
                echo "Update_Tb"
                ./Tables_manipulation/Update.sh
            ;;
            *)
                echo "Wrong input"
            ;;
            esac
    done

else
    echo "This Database doesn't exist!!"
    
fi


