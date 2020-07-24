FROM mysql:8.0.21

COPY ./*.sql /docker-entrypoint-initdb.d/
#COPY ./alldb.sql /docker-entrypoint-initdb.d/alldb.sql

CMD ["mysqld"]
