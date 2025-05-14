# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory for the build stage
WORKDIR /usr/app

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY src /usr/app/src

# Package the application into a jar file
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:17-jre-slim

# Set the working directory for the runtime container
WORKDIR /usr/app

# Copy the jar file from the build stage
COPY --from=build /usr/app/target/pet-clinic-1.0.0.jar pet-clinic.jar

# Expose the port that the application will run on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "pet-clinic.jar"]
