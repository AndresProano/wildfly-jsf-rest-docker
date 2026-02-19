# ⚡ Quick Start (2 minutos)

## A. Si solo quieres ejecutar la app (Sin compilar)

```bash
# 1. Descargar imágenes
docker compose pull

# 2. Iniciar
docker compose up -d

# 3. Espera 15-30 segundos, luego abre:
```

### 🌐 Abre en tu navegador:

- **Interfaz Web:** http://localhost:8080
- **API REST:** http://localhost:8081/api/saludo

### ⏹️ Detener:

```bash
docker compose down
```

---

## ¿Tienes problemas?

| Problema | Solución |
|----------|----------|
| "Docker daemon error" | Abre Docker Desktop |
| "Port already in use" | Cambia puerto en `docker-compose.yml` |
| "Page not found" | Espera 30 segundos (WildFly está iniciando) |
| "More help needed" | Lee [README.md](README.md) |

---

## 👨‍💻 B. Si vas a compilar código

Este repositorio incluye un archivo de referencia llamado:
docker-compose-build.yml
El objetivo de ese archivo es construir las imágenes localmente antes de subirlas a Docker Hub.
```bash 
# 1) Compilar los WAR (obligatorio antes del build Docker)
cd app-rest && mvn clean package && cd ..
cd app-jsf  && mvn clean package && cd ..

# 2) Construir y ejecutar con compose de build
docker compose -f docker-compose-build.yml build --no-cache
docker compose -f docker-compose-build.yml up -d

# 3) Probar
Interfaz Web (JSF): http://localhost:8080
API REST:           http://localhost:8081/api/saludo

# 4) Subir a Docker Hub
./deber1.sh push

# 5) Reiniciar
docker compose pull && docker compose down && docker compose up -d
```

---

**¿Listo?** Ejecuta:

```bash
docker compose up -d
```

Abre http://localhost:8080 en tu navegador. ✨
