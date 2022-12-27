#!/usr/bin/bash
clear
echo "Available Data base: "
echo "-----------------------------------"
ls -F ~/DataBase| grep "/" | cut -d / -f1
echo "-----------------------------------"
read -p "Insert the Data base name: "  DB_name
while [[ ! $DB_name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
do
    echo "enter valid name!! "
    read DB_name
done
if [[ -d ~/DataBase/$DB_name ]] ; then
    select input in Create_Tb list_Tb Drop_Tb Insert_Tb Delete Select_TB Update_Tb Go_back
    do 
            case $input in 
            Create_Tb )
                echo "Create_Tb"
                ./Tables_manipulation/CreateTb.sh $DB_name
            ;;
            list_Tb )
                echo "list_Tb"
                ./Tables_manipulation/ListTb.sh $DB_name
            ;;
            Drop_Tb )
                echo "Drop_Tb"
                ./Tables_manipulation/DropTb.sh $DB_name
            ;;
            Insert_Tb )
                echo "Insert_Tb"
                ./Tables_manipulation/Insert.sh $DB_name
            ;;
            Delete )
                echo "Delete_Tb"
                ./Tables_manipulation/Delete.sh  $DB_name
            ;;
            Select_TB )
                echo "Select_TB"
                ./Tables_manipulation/Select.sh $DB_name
            ;;
            Update_Tb )
                echo "Update_Tb"
                ./Tables_manipulation/Update.sh $DB_name
            ;;
            Go_back )
                ./main.sh
            ;;
            *)
                echo "Wrong input "
            ;;
            esac
    done

else
    echo "This Database doesn't exist!! "
    echo "Do you want to create a new database "
    select input in yes no
    do
        case $input in 
            yes)
            ./DB_manipulation/CreateDB.sh
            ;;
            no)
            ./main.sh
            ;;
            *)
            echo "wrong input!!  "
            ;;
            esac
    done
    ./Tables_manipulation/TbMenu.sh 
fi


