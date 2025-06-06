# Финальный образ
FROM eclipse-temurin:24-jre-alpine
# Явно указываем платформу (можно также указать при сборке через --platform)
# ARG TARGETARCH
# ARG TARGETOS
# FROM --platform=linux/amd64 eclipse-temurin:24-jre-jammy
WORKDIR /app
# Копируем собранный JAR из стадии builder
COPY build/libs/sweetshop-backend-1.0.3.jar app.jar
# Открываем порт приложения
EXPOSE 8080
# Запускаем приложение с оптимальными настройками для контейнера
ENTRYPOINT ["java", "-jar", "app.jar"]