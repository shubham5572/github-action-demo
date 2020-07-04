FROM maven:3.6.3-8-jdk-alpine AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B -f pom.xml clean package -DskipTests

FROM java:8-jdk-alpine
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8096
ENTRYPOINT ["java","-jar","app.jar"]