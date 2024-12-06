# Paso 1: Construir la aplicación
FROM maven:3.8.5-openjdk-17-slim AS builder

# Establecer el directorio de trabajo para el build
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . .

# Ejecutar Maven para empaquetar la aplicación
RUN mvn clean package -DskipTests

# Paso 2: Crear la imagen de ejecución
FROM openjdk:17-jdk-slim

# Establecer el directorio de trabajo para la ejecución
WORKDIR /app

# Copiar el archivo JAR empaquetado desde el paso anterior
COPY --from=builder /app/target/*.jar app.jar

# Exponer el puerto en el que la aplicación escucha
EXPOSE 8083

# Comando para ejecutar la aplicación
CMD ["sh", "-c", "java -jar /app/app.jar \"$URL_PAYMENTS\" \"$URL_SHIPPING\" \"$URL_PRODUCTS\""]