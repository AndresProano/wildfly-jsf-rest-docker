# Deber 1 - Jakarta EE + WildFly + Docker

## 👥 Integrantes
- Andrés Proaño (00326003) - Colaboración: crear docker compose y cargar a docker hub el proyecto
- Pablo Alvarado (00344965) - Colaboración:  crear Rest App y JSF

---

## 📋 Estructura del Proyecto

```
deber1/
├── app-rest/                    # Servicio REST Backend
│   ├── src/main/java/
│   │   ├── RestConfiguration.java
│   │   └── SaludoResource.java
│   ├── src/main/webapp/WEB-INF/
│   │   └── web.xml
│   ├── pom.xml
│   └── Dockerfile
│
├── app-jsf/                     # Cliente JSF Frontend
│   ├── src/main/java/
│   │   └── SaludoBean.java
│   ├── src/main/webapp/
│   │   ├── index.xhtml
│   │   └── WEB-INF/
│   │       └── web.xml
│   ├── pom.xml
│   └── Dockerfile
│
├── docker-compose.yml           # Configuración de orquestación
└── README.md                    # Este archivo
```

### Descripción de Servicios

| Servicio | Tecnología | Puerto | Función |
|----------|-----------|--------|---------|
| **REST (app-rest)** | Jakarta REST API | 8081 | Provee endpoint de saludo |
| **JSF (app-jsf)** | Jakarta Faces | 8080 | Interfaz web que consume REST |

**Detalles técnicos:**
- Ambas aplicaciones se despliegan como `ROOT.war` en WildFly
- Se comunican internamente: `jsf → http://rest-service:8080/api/saludo`
- Las imágenes Docker soportan **amd64** (Windows/Linux) y **arm64** (Mac)

---

## 🚀 Guía Rápida de Ejecución

### Para Usuarios y Evaluadores (Sin compilar código)

Si solo necesitas **ejecutar la aplicación** precompilada:

#### ✅ Paso 1: Verificar requisitos

```bash
docker --version
docker compose version
```

Si no tienes Docker instalado:
- **Windows:** Descarga [Docker Desktop para Windows](https://www.docker.com/products/docker-desktop/)
- **Mac:** Descarga [Docker Desktop para Mac](https://www.docker.com/products/docker-desktop/)
- **Linux:** Instala desde el repositorio de tu distribución

#### ✅ Paso 2: Descargar imágenes más recientes

```bash
docker compose pull
```

Este comando descargará automáticamente las versiones correctas para tu arquitectura:
- `linux/amd64` en Windows/Linux
- `linux/arm64` en Mac con Apple Silicon

Nota: Esto debe ejecutarse en la raiz del proyecto. Donde se encuentra el archivo docker-compose.yml

#### ✅ Paso 3: Iniciar la aplicación

```bash
docker compose up -d
```

**Salida esperada:**
```
[+] Running 3/3
 ✔ Network deber1_default    Created
 ✔ Container rest-container  Healthy
 ✔ Container jsf-container   Started
```

#### ✅ Paso 4: Acceder a la aplicación

Espera **15-30 segundos** mientras WildFly inicia. Luego abre en tu navegador:

- **🌐 Interfaz Web (JSF):** [http://localhost:8080](http://localhost:8080)
  - Aquí encontrarás un botón "Call Rest"
  - Al hacer clic, llamará al backend y mostrará la respuesta

- **⚙️ API REST (Endpoint):** [http://localhost:8081/api/saludo](http://localhost:8081/api/saludo)
  - Devuelve: `Hello World desde el contenedor REST`

#### ✅ Paso 5: Detener la aplicación

```bash
docker compose down
```

---

## 🛠️ Guía de Desarrollo

### Para Desarrolladores (Compilar y Subir Cambios)

Si necesitas **modificar el código**, compilarlo y subir nuevas versiones:

#### Requisitos Previos

- **Java 17:** [Descarga aquí](https://www.oracle.com/java/technologies/downloads/#java17)
- **Maven 3.8+:** [Descarga aquí](https://maven.apache.org/download.cgi)
- **Docker:** [Descarga aquí](https://www.docker.com)

#### 1️⃣ Compilar los WARs

En la raíz del proyecto:

```bash
# Compilar REST
mvn -f app-rest/pom.xml clean package

# Compilar JSF
mvn -f app-jsf/pom.xml clean package
```

**Resultado esperado:**
- `app-rest/target/app-rest.war`
- `app-jsf/target/app-jsf.war`

#### 2️⃣ Crear y subir imágenes multiplataforma a Docker Hub

##### Configurar Docker Hub (Solo primera vez)

```bash
# Iniciar sesión en Docker Hub
docker login
# Ingresa tu usuario y contraseña

# Crear un builder que soporte múltiples arquitecturas
docker buildx create --name multiarch-builder --use
```

##### Compilar y subir imágenes

```bash
# Servicio REST
docker buildx build --platform linux/amd64,linux/arm64 \
  -t byandyx/deber1-rest-server:latest \
  -f app-rest/Dockerfile . --push

# Servicio JSF
docker buildx build --platform linux/amd64,linux/arm64 \
  -t byandyx/deber1-jsf-server:latest \
  -f app-jsf/Dockerfile . --push
```

**Nota:** Reemplaza `byandyx` con tu usuario de Docker Hub real.

#### 3️⃣ Actualizar docker-compose.yml (si es necesario)

Si cambiaste el nombre de usuario, actualiza:

```yaml
services:
  rest-service:
    image: TU_USUARIO/deber1-rest-server:latest
    # ...
  
  jsf-service:
    image: TU_USUARIO/deber1-jsf-server:latest
    # ...
```

#### 4️⃣ Probar localmente los cambios

```bash
docker compose pull      # Descargar imágenes actualizadas
docker compose down      # Detener contenedores antiguos
docker compose up -d     # Iniciar con cambios nuevos
```

Verifica en:
- [http://localhost:8080](http://localhost:8080) (Interfaz JSF)
- [http://localhost:8081/api/saludo](http://localhost:8081/api/saludo) (API REST)

---

## 🐧 Instalación en WSL (Windows Subsystem for Linux)

Si usas Windows con WSL (Windows Subsystem for Linux):

### Java + Maven en WSL

```bash
# Actualizar paquetes
sudo apt update

# Instalar Java 17
sudo apt install -y openjdk-17-jdk

# Instalar Maven
sudo apt install -y maven

# Verificar instalaciones
java -version
mvn -v
```

### Docker en WSL

**Opción A: Docker Desktop (Recomendada)**

1. Descarga [Docker Desktop para Windows](https://www.docker.com/products/docker-desktop/)
2. Instala normalmente en Windows
3. Ve a Settings → Resources → WSL Integration
4. Activa la integración con tu distribución WSL
5. En WSL verifica:

```bash
docker version
docker compose version
```

**Opción B: Docker directamente en WSL**

```bash
# Instalar Docker CLI
sudo apt update
sudo apt install -y docker.io docker-compose-plugin

# Permitir usar docker sin sudo
sudo usermod -aG docker $USER
newgrp docker

# Verificar
docker version
docker compose version
```

---

## 🧪 Pruebas y Debugging

### Verificar que los servicios responden

```bash
# Probar endpoint REST
curl http://localhost:8081/api/saludo
# Respuesta esperada: Hello World desde el contenedor REST

# Probar interfaz JSF (obtiene HTML)
curl http://localhost:8080/
```

### Ver logs de los contenedores

```bash
# Logs de ambos servicios
docker compose logs -f

# Solo REST
docker compose logs -f rest-service

# Solo JSF
docker compose logs -f jsf-service
```

### Listar contenedores ejecutándose

```bash
docker ps
```

**Salida esperada:**
```
CONTAINER ID   IMAGE                              PORTS                    NAMES
abc123...      byandyx/deber1-jsf-server:latest   0.0.0.0:8080->8080/tcp   jsf-container
def456...      byandyx/deber1-rest-server:latest  0.0.0.0:8081->8080/tcp   rest-container
```

### Detener y limpiar todo

```bash
# Detener contenedores
docker compose down

# Eliminar también volúmenes (datos)
docker compose down -v

# Eliminar imágenes locales (para descargar nuevas)
docker rmi byandyx/deber1-rest-server:latest
docker rmi byandyx/deber1-jsf-server:latest
```

---

## 📦 Información de Docker Hub

| Recurso | Ubicación |
|---------|-----------|
| **REST Image** | `byandyx/deber1-rest-server:latest` |
| **JSF Image** | `byandyx/deber1-jsf-server:latest` |
| **Plataformas** | Linux AMD64 (Windows/Linux) + ARM64 (Mac) |
| **Base** | WildFly 39+ |

---

## 🔧 Troubleshooting

### Error: "Cannot connect to Docker daemon"

**Solución:**
- Asegúrate de que Docker Desktop está ejecutándose
- En Linux, inicia el servicio: `sudo systemctl start docker`

### Error: "Port 8080 is already allocated"

**Solución:** Cambiar puertos en `docker-compose.yml`:

```yaml
services:
  jsf-service:
    ports:
      - "8090:8080"  # Cambiar 8090 a puerto disponible
```

### Conexión rechazada entre JSF y REST

**Verificar:**
```bash
# Entrar al contenedor JSF
docker exec -it jsf-container bash

# Probar conexión al REST
curl http://rest-service:8080/api/saludo
```

Si falla, revisar que en `SaludoBean.java` la URL sea correcta:
```java
client.target("http://rest-service:8080/api/saludo")
```

### Página no encontrada en localhost:8080

**Esperar un poco más:** WildFly puede tardar 30 segundos en desplegar completamente.

```bash
# Ver logs de JSF
docker compose logs jsf-service
```

Busca `Deployed "ROOT.war"` para confirmar que se desplegó.

---

## 📚 Referencias

- [Jakarta EE 10](https://jakarta.ee)
- [WildFly 39+](https://www.wildfly.org/)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)

---

## 📝 Notas Importantes

✅ **Las imágenes ya están compiladas en Docker Hub:**
- No necesitas Maven ni Java para ejecutar la aplicación
- Solo descargar con `docker compose pull`

✅ **Soportan múltiples arquitecturas:**
- Windows y Linux: Usa `linux/amd64`
- Mac con Apple Silicon: Usa `linux/arm64`
- La selección es automática

✅ **Evaluadores pueden ejecutar desde cualquier lugar:**
- Solo necesitan `docker-compose.yml`
- Las imágenes se descargan automáticamente

---

**¿Problemas?** Revisa los logs:
```bash
docker compose logs -f
```
