#use openjdk 17 as the base image
FROM openjdk:17-jdk-slim


# set working directory inside container
WORKDIR /app

#copy the compiled jar into container
COPY target/pet-clinic-1.0.0.jar app.jar

#commad to run the jar
ENTRYPOINT ["java", "-jar","app.jar"]
