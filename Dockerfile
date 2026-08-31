FROM maven:3-eclipse-temurin-21-alpine AS builder
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM eclipse-temurin:21-alpine
LABEL author=shaikkhajaibrahim
LABEL project=learning
LABEL version=3.3.0
RUN adduser -D -h /app -s /bin/sh spc
USER spc
EXPOSE 8080
COPY --from=builder --chown=spc:spc /spc/target/spring-petclinic-4.0.0-SNAPSHOT.jar /app/spring-petclinic-4.0.0-SNAPSHOT.jar
WORKDIR /app
CMD ["java", "-jar", "spring-petclinic-4.0.0-SNAPSHOT.jar"]
