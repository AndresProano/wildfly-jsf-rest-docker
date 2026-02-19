# 📚 Documentación - Deber 1

Bienvenido al proyecto Deber 1. Esta carpeta contiene toda la información necesaria para ejecutar, compilar y desplegar la aplicación.

---

## 🎯 ¿Por Dónde Empiezo?

### 👤 Si solo eres usuario/evaluador (quieres ejecutar la app)

1. **Leer:** [WINDOWS.md](WINDOWS.md) (Windows) o [MACOS.md](MACOS.md) (Mac)
2. **Ejecutar:**
   ```bash
   docker compose pull
   docker compose up -d
   ```
3. **Acceder:** 
   - Web: http://localhost:8080
   - API: http://localhost:8081/api/saludo

---

### 👨‍💻 Si eres desarrollador (vas a modificar código)

1. **Leer:** [README.md](README.md) (Documentación completa)
2. **Requisitos:** Java 17, Maven, Docker
3. **Compilar:**
   ```bash
   mvn -f app-rest/pom.xml clean package
   mvn -f app-jsf/pom.xml clean package
   ```
4. **Subir cambios a Docker Hub:**
   ```bash
   ./deber1.sh push
   ```

---

## 📄 Archivos de Documentación

| Archivo | Propósito | Para Quién |
|---------|-----------|-----------|
| **README.md** | Documentación completa y detallada | Todos |
| **WINDOWS.md** | Guía paso a paso para Windows | Usuarios Windows |
| **MACOS.md** | Guía paso a paso para macOS | Usuarios Mac |
| **this file** | Índice de documentación | Todos |

---

## 🔧 Archivos de Configuración

| Archivo | Propósito |
|---------|-----------|
| **docker-compose.yml** | Configuración de orquestación Docker |
| **.env.example** | Variables de configuración (ejemplo) |
| **deber1.sh** | Script helper con comandos útiles |

---

## 🚀 Comandos Rápidos

### Usuarios Finales

```bash
# Iniciar aplicación
docker compose up -d

# Detener aplicación
docker compose down

# Ver logs
docker compose logs -f
```

### Desarrolladores

```bash
# Compilar
mvn clean package

# Compilar y subir
./deber1.sh push

# Con el script helper
./deber1.sh start
./deber1.sh logs
./deber1.sh stop
```

---

## 🌐 URLs de Acceso

| Servicio | URL | Descripción |
|----------|-----|-------------|
| **JSF (Interfaz Web)** | http://localhost:8080 | Aplicación frontend |
| **REST (API)** | http://localhost:8081/api/saludo | Endpoint backend |

---

## 📦 Contenido del Proyecto

```
deber1/
├── 📄 README.md           ← Leer esto primero
├── 📄 WINDOWS.md          ← Para usuarios Windows
├── 📄 MACOS.md            ← Para usuarios Mac
├── 🔧 docker-compose.yml  ← Configuración Docker
├── 🔧 .env.example        ← Variables de ejemplo
├── 🔧 deber1.sh           ← Script helper
│
├── app-rest/              ← Servicio REST Backend
│   ├── src/main/java/     ← Código fuente
│   ├── src/main/webapp/   ← Archivos web
│   ├── pom.xml            ← Config Maven
│   └── Dockerfile         ← Config Docker
│
└── app-jsf/               ← Cliente JSF Frontend
    ├── src/main/java/     ← Código fuente
    ├── src/main/webapp/   ← Archivos web
    ├── pom.xml            ← Config Maven
    └── Dockerfile         ← Config Docker
```

---

## ⚡ Guía Rápida (5 minutos)

### Opción 1: Ejecutar (Sin compilar)

```bash
# 1. Descargar imágenes
docker compose pull

# 2. Iniciar
docker compose up -d

# 3. Acceder (después de 15-30 segundos)
# - Abre http://localhost:8080 en tu navegador
# - Haz clic en "Call Rest"
```

### Opción 2: Desarrollar (Compilar cambios)

```bash
# 1. Editar código en app-rest/ o app-jsf/

# 2. Compilar
mvn clean package

# 3. Actualizar imágenes
./deber1.sh push

# 4. Reiniciar
docker compose pull
docker compose down
docker compose up -d
```

---

## 🐛 Solución de Problemas

**Error: "Couldn't connect to Docker daemon"**
→ Abre Docker Desktop

**Error: "Port 8080 already in use"**
→ Cambia puertos en `docker-compose.yml`

**Página no carga**
→ Espera 30 segundos (WildFly está iniciando)

**Más ayuda:**
→ Lee [README.md](README.md) sección "Troubleshooting"

---

## 📞 Soporte

1. **Documentación:** Lee [README.md](README.md)
2. **Logs:** `docker compose logs -f`
3. **Estado:** `docker ps`

---

## 📋 Información Técnica

- **Lenguaje:** Java 17 (Jakarta EE 10)
- **Framework Web:** Jakarta Faces (JSF)
- **API REST:** Jakarta REST (JAX-RS con RESTEasy)
- **Servidor:** WildFly 39.0+
- **Orquestación:** Docker Compose
- **Imágenes:** Docker Hub (Multi-arquitectura: amd64 + arm64)

---

## ✅ Verificación de Instalación

Antes de empezar, verifica que tengas lo necesario:

```bash
# Verificar Docker
docker --version

# Verificar Docker Compose
docker compose version

# Verificar Java (si vas a compilar)
java -version

# Verificar Maven (si vas a compilar)
mvn -v
```

---

## 🎓 Próximos Pasos

1. ✅ Lee la documentación apropiada (WINDOWS.md o MACOS.md)
2. ✅ Ejecuta `docker compose up -d`
3. ✅ Abre http://localhost:8080 en tu navegador
4. ✅ Haz clic en "Call Rest" para probar la integración
5. ✅ Revisa los logs con `docker compose logs` si algo no funciona

---

**¡Listo para empezar? Lee [README.md](README.md) o tu guía específica (WINDOWS.md / MACOS.md)** 🚀
