create user 'sync'@'%' identified with mysql_native_password by 'yixun2020Sync!';
grant all privileges on *.* to 'sync'@'%';
flush privileges;