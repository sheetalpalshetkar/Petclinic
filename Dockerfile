# Use OpenJDK 11 base image
FROM openjdk:17-jre-slim

# Set the working directory inside the container
WORKDIR /usr/app

# Copy the Spring Boot jar file into the container
COPY target/pet-clinic-1.0.0.jar pet-clinic.jar

# Run the jar file
ENTRYPOINT ["java", "-jar", "pet-clinic.jar"]
	
