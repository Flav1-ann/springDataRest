FROM maven:3.8.4-openjdk-11-slim as build
RUN mkdir msCompte
WORKDIR /msCompte
COPY ./ ./
RUN mvn clean package spring-boot:repackage
RUN ls
RUN ls ./target

FROM gcr.io/distroless/java:11
COPY --from=build /msCompte/target/*.jar /jar-files/msCompte.jar
WORKDIR /jar-files

EXPOSE 8083
CMD [ "msCompte.jar" ]