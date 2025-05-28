# ---------- Stage 1: Build ----------
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

# Copy all project files to container
COPY . .

# Build the project using Maven
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run ----------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from the previous build stage
COPY --from=build /app/target/*.jar app.jar

# Match this with the port in application.properties
EXPOSE 5454

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
