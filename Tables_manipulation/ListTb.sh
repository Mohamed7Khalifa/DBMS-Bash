$1
echo "The available Tables are: "
echo "---------------------------------"
ls -F ~/DataBase/$1/ | grep -v "/"
echo "---------------------------------"