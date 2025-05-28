# ---------- Stage 1: Build ----------
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

# Copy all project files
COPY . .

# Build the project using Maven
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run ----------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from the previous build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
