FROM openjdk-17

WORKDIR /app

COPY . .

RUN mvn clean package

CMD ["java" "-jar" "
