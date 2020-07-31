-- CREATE user 'repl'@'%' identified with mysql_naca by 'replica123456' ;
-- GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%'  ;
-- CREATE user 'release'@'%' identified by 'replica123456';
-- GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%'  ;

create database Auth;
create database Chat;
create database BaseData;
create database ConsumeCount;
create database DataCentre;
create database LayoutData;

