FROM openjdk:17-alpine

RUN apk update && apk add --no-cache maven

WORKDIR /app

COPY pom.xml ./
RUN mvn dependency:go-offline

COPY . .
RUN mvn clean package

EXPOSE 8000
CMD ["java", "-jar", "/app/target/backend-1.0-SNAPSHOT.jar"]

