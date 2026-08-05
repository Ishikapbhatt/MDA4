FROM mariadb:10.11

ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=student_db
ENV MYSQL_USER=admin
ENV MYSQL_PASSWORD=adminpassword

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
