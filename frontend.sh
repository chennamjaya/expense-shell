source common.sh
component=frontend 

echo Installing Nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
 echo -e "\e[32mSuccess\e[0m"
else
 echo -e "\e[31mFailed\e[0m"
 exit 1
fi

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ]; then
 echo -e "\e[32mSuccess\e[0m"
else
 echo -e "\e[31mFailed\e[0m"
 exit 1
fi

echo Removing Old Nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0 ]; then
 echo -e "\e[32mSuccess\e[0m"
else
 echo -e "\e[31mFailed\e[0m"
 exit 1
fi

cd /usr/share/nginx/html 

download_and_extract
if [ $? -eq 0 ]; then
 echo -e "\e[32mSuccess\e[0m"
else
 echo -e "\e[31mFailed\e[0m"
 exit 1
fi

echo Starting Nginx code
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
if [ $? -eq 0 ]; then
 echo -e "\e[32mSuccess\e[0m"
else
 echo -e "\e[31mFailed\e[0m"
 exit 1
fi
