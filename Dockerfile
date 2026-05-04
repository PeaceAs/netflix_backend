FROM ubuntu:noble

RUN apt update -y && \
    apt install -y openjdk-17-jre-headless maven && \
    apt clean

WORKDIR /app

COPY .env /app/src/main/resources/.env
COPY ./src /app/src
COPY ./pom.xml /app

RUN mvn -f /app/pom.xml clean package -DskipTests
RUN ls -al /app/target

COPY ./target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]