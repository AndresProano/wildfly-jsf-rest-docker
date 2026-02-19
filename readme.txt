# Deber 1 - Jakarta EE + WildFly + Docker

## Integrantes
- NOMBRE AQUI
- NOMBRE AQUI

## Estructura del Proyecto
- **REST (app-rest):** Servicio Backend que provee la API REST
- **JSF (app-jsf):** Cliente Frontend que consume la API REST

Las imágenes están alojadas en Docker Hub y funcionan en arquitecturas **amd64** (Windows/Linux estándar) y **arm64** (Mac Apple Silicon).

---

## 🚀 Guía Rápida de Ejecución (Usuarios y Evaluadores)

Si solo deseas **ejecutar la aplicación** sin compilar código, sigue estos pasos:

### Requisitos previos
- **Docker** y **Docker Compose** instalados y ejecutándose
- Solo necesitas el archivo `docker-compose.yml`

### 1. Descargar las imágenes más recientes

```bash
docker compose pull
```

### 2. Levantar los contenedores

```bash
docker compose up -d
```

### 3. Acceder a la Aplicación

Espera 15-30 segundos para que WildFly termine de arrancar, luego abre:

- **🌐 Interfaz Web (JSF):** http://localhost:8080/
- **⚙️ API REST (Endpoint):** http://localhost:8081/api/saludo

### 4. Detener la aplicación

```bash
docker compose down
```

---

## 🛠️ Guía de Desarrollo (Compilar y Subir Imágenes)

Si modificas el código fuente, sigue estos pasos:

### Requisitos
- Java 17
- Maven 3.8+
- Docker + Docker Compose

### 1. Compilar los WARs

```bash
mvn -f app-rest/pom.xml clean package
mvn -f app-jsf/pom.xml clean package
```

### 2. Crear imágenes multiplataforma y subirlas a Docker Hub

```bash
# Iniciar sesión en Docker Hub
docker login

# Crear builder para múltiples plataformas (solo primera vez)
docker buildx create --name multiarch-builder --use

# Compilar y subir REST (amd64 + arm64)
docker buildx build --platform linux/amd64,linux/arm64 \
  -t byandyx/deber1-rest-server:latest \
  -f app-rest/Dockerfile . --push

# Compilar y subir JSF (amd64 + arm64)
docker buildx build --platform linux/amd64,linux/arm64 \
  -t byandyx/deber1-jsf-server:latest \
  -f app-jsf/Dockerfile . --push
```

Luego, actualizar en localhost:
```bash
docker compose pull
docker compose down
docker compose up -d
```

---

## 🐧 Instalación Rápida en WSL (Windows)

### Java + Maven
```bash
sudo apt update
sudo apt install -y openjdk-17-jdk maven
java -version
mvn -v
```

### Docker en WSL

**Opción A (Recomendada):** Docker Desktop en Windows + WSL integration
```bash
# En WSL, verifica:
docker version
docker compose version
```

**Opción B (Solo WSL sin Desktop):**
```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker
```

---

## 📝 Información de Docker Hub

- **REST Image:** `byandyx/deber1-rest-server:latest`
- **JSF Image:** `byandyx/deber1-jsf-server:latest`
- **Soportan:** Linux AMD64 (Windows/Linux) + ARM64 (Mac)

---

## ⚡ Pruebas Rápidas

```bash
# Verificar que REST responde
curl http://localhost:8081/api/saludo

# Verificar logs de los contenedores
docker compose logs -f

# Detener todo
docker compose down
```
