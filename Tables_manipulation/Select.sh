#!/usr/bin/bash
echo "choose the type of select u want " 

select input in Select_All Select_column Select_with_Condition
do
    case $input in
    Select_All ) 
    
    ;;
    Select_column ) 
    
    ;;
    Select_with_Condition )

    ;;
    * )
        echo "Wrong input"
        ./Tables_manipulation/Select.sh
    ;;
    esac 
done