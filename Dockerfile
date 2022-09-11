FROM maven:3.8.6-openjdk-11 AS build

ENV DB_URL=mysql
ENV DB_PORT=3306
ENV DB_NAME=tawazun 
ENV DB_USERNAME=root
ENV DB_PASSWORD=Fatm20

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "clean"]

COPY ["/src", "/app/src"]
RUN ["mvn", "package"]

FROM openjdk:11-jre-slim

COPY --from=build /app/target/tawazun.war /

EXPOSE 8080
CMD ["java", "-jar", "/tawazun.war"]