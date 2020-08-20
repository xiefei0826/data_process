FROM mysql:8.0.21

COPY ./*.sql /docker-entrypoint-initdb.d/
#COPY ./createuser.sql /docker-entrypoint-initdb.d/createuser.sql

CMD ["mysqld"]
