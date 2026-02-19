# ⚡ Quick Start (2 minutos)

## Si solo quieres ejecutar la app (Sin compilar)

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

## 👨‍💻 Si vas a compilar código

```bash
# Compilar
mvn clean package

# Subir a Docker Hub
./deber1.sh push

# Reiniciar
docker compose pull && docker compose down && docker compose up -d
```

---

**¿Listo?** Ejecuta:

```bash
docker compose up -d
```

Abre http://localhost:8080 en tu navegador. ✨
