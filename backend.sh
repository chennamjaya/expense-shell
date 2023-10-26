source common.sh

component=backend 

echo Install NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file

echo Install NodeJS
dnf install nodejs -y >>$log_file

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo Add Application User
useradd expense >>$log_file

echo Clean App Content
rm -rf /app >>$log_file
mkdir /app 

cd /app

download_and_extract

echo Download Dependencies
npm install >>$log_file

echo Start Backend Service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo Install MySQL Client
dnf install mysql -y >>$log_file

echo Load Schema
mysql -h mysql.vaishnavidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file