# Use the official maven/Java 11 image to create a build artifact.
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory.
WORKDIR /app

# Copy the pom.xml file and install dependencies.
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and package/build the application.
COPY src ./src
RUN mvn clean package -DskipTests

# Use the official OpenJDK 11 image to run the application.
FROM openjdk:17-jdk-slim

# Set the working directory.
WORKDIR /app

# Copy the built JAR file from the build stage to the production image.
COPY --from=build /app/target/email-assistant-0.0.1-SNAPSHOT.jar .

# Expose the PORT 8080.
EXPOSE 8080

# Run the JAR file.
ENTRYPOINT ["java", "-jar", "email-assistant-0.0.1-SNAPSHOT.jar"]