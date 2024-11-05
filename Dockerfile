FROM openjdk-17

WORKDIR /app

COPY . .

RUN mvn clean package

EXPOSE 3000

CMD ["java" "-jar" "AjayApplication.java"]


