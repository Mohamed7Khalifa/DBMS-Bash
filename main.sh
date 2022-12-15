#!/usr/bin/bash
select input in Create_DB list_DB Connect_DB Drop_DB
do 
    case $input in 
    Create_DB )
        echo "create DB"
        ./DB_manipulation/CreateDB.sh
    ;;
    list_DB )
        echo "list DB"
        ./DB_manipulation/ListDB.sh
    ;;
    Drop_DB )
        echo "Drop DB"
        ./DB_manipulation/DropDB.sh
    ;;
    Connect_DB )
        echo "Connect DB"
    ;;
    *)
        echo "Wrong input"
    ;;
    esac
done

function tbMenu() {
    select input in Create_Tb list_Tb Drop_Tb Insert_Tb Delete_Tb Select_TB Update_Tb
do 
    case $input in 
    Create_Tb )
        echo "Create_Tb"
        
    ;;
    list_Tb )
        echo "list_Tb"
        
    ;;
    Drop_Tb )
        echo "Drop_Tb"
    ;;
    Insert_Tb )
        echo "Insert_Tb"
        
    ;;
    Delete_Tb )
        echo "Delete_Tb"
        
    ;;
    Select_TB )
        echo "Select_TB"
        
    ;;
    Update_Tb )
        echo "Update_Tb"
        
    ;;
    *)
        echo "Wrong input"
    ;;
    esac
done

}