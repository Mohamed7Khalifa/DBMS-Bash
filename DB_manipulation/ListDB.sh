echo "Hello this the DataBase avilable: " 
echo "---------------------------------"
ls -F ./DataBase| grep "/" | cut -d / -f1
echo "---------------------------------"