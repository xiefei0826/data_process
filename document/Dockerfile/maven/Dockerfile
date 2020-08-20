FROM maven:3.6.3-slim
COPY ./settings.xml /usr/share/maven/conf/settings.xml
WORKDIR /app
COPY ./pom.xml .
RUN mvn -B dependency:resolve

