# Deber 1 - Jakarta EE + WildFly + Docker

## Integrantes
- NOMBRE AQUI
- NOMBRE AQUI

## Estructura
- REST: app-rest (WAR `app-rest.war`)
- JSF: app-jsf (WAR `app-jsf.war`)

## Requisitos
- Java 17
- Maven 3.8+
- Docker + Docker Compose

## WSL (instalacion rapida)
### Java + Maven
```bash
sudo apt update
sudo apt install -y openjdk-17-jdk maven
java -version
mvn -v
```

### Docker (WSL)
Opcion A (recomendada): Docker Desktop en Windows + activar WSL integration.
Verifica en WSL:
```bash
docker version
docker compose version
```

Opcion B (solo WSL, sin Desktop):
```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker
docker version
docker compose version
```

## Build
```bash
mvn -f app-rest/pom.xml clean package
mvn -f app-jsf/pom.xml clean package
```

## Docker (build + run)
```bash
docker compose build
docker compose up
```

## URLs finales (docker-compose)
- REST: http://localhost:8081/app-rest/api/saludo
- JSF:  http://localhost:8080/app-jsf/

## Pruebas
```bash
# REST
curl http://localhost:8081/app-rest/api/saludo
```

Abrir en navegador:
- http://localhost:8080/app-jsf/

## Docker Hub (si se requiere)
```bash
# Tag
docker tag app-rest:latest <dockerhub_user>/app-rest:1.0
docker tag app-jsf:latest <dockerhub_user>/app-jsf:1.0

# Login y push
docker login
docker push <dockerhub_user>/app-rest:1.0
docker push <dockerhub_user>/app-jsf:1.0
```
