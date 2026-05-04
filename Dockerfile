FROM eclipse-temurin:17-jre-noble

RUN apt-get update -y && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app

RUN mvn -f /app/pom.xml clean package -DskipTests

COPY ./target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]