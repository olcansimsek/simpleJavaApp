# syntax=docker/dockerfile:1

FROM openjdk:16-alpine3.13 as jdk16
WORKDIR /app
COPY . /app
RUN ./mvnw package -DskipTests



FROM openjdk:16-alpine3.13
COPY --from=jdk16 /app/target/*.jar ./app/app.jar

RUN addgroup --system javauser && adduser -S -s /bin/false -G javauser javauser
RUN chown -R javauser:javauser /app

USER javauser

CMD ["java","-jar", "./app/app.jar"]