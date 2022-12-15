#!/usr/bin/bash
read -p "Insert the table name : "  tbName
if [[-f $tbName ]] ; then
    echo "the table is already exist!!"
else
    if [[ $tbName =~ ['!@#$%^&*()_+'] || $tbName =~ [0-9] ]] ; then
        echo "Error!!"
    else
        echo "done!!"
        # touch $tbName
    fi
fi
