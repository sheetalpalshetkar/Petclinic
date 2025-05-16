# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /usr/app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src /usr/app/src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image
FROM openjdk:17-slim

WORKDIR /usr/app
COPY --from=build /usr/app/target/pet-clinic-1.0.0.jar pet-clinic.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "pet-clinic.jar"]
