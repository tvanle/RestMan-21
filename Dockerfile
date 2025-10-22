# Build stage
FROM maven:3.8.6-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:9.0-jdk8-openjdk
WORKDIR /usr/local/tomcat

# Remove default webapps
RUN rm -rf webapps/*

# Copy WAR file
COPY --from=build /app/target/RestMan.war webapps/RestMan.war

# Expose port
EXPOSE 8080

CMD ["catalina.sh", "run"]
