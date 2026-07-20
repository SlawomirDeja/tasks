FROM eclipse-temurin:21 AS build
WORKDIR /app
COPY build.gradle .
COPY settings.gradle .
COPY src src

COPY gradlew .
COPY gradle gradle

RUN chmod +x ./gradlew
RUN ./gradlew build -x test

FROM eclipse-temurin:21
VOLUME /tmp

COPY --from=build /app/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
EXPOSE 8080
