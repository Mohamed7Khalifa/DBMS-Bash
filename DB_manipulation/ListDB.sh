echo "hello this the DataBase avilable: " 
echo "---------------------------------"
ls -l | grep ^d |cut -d " " -f 9
echo "---------------------------------"