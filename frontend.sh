log_file=/tmp/expense.log

echo Installing Nginx
dnf install nginx -y >>$log_file

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo Removing Old Nginx content
rm -rf /usr/share/nginx/html/* >>$log_file

echo Donwload Frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html 

echo Extracting Frontend code
unzip /tmp/frontend.zip >>$log_file

echo Starting Nginx code
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file

