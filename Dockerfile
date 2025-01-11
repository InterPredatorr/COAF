FROM gradle:8.7-jdk17 AS build
COPY --chown=gradle:gradle . ./server
WORKDIR ./server
RUN gradle buildFatJar --no-daemon

FROM openjdk:17
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build ./server/build/libs/*.jar /app/COAF.jar
ENTRYPOINT ["java","-jar","/app/COAF.jar"]