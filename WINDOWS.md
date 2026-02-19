# 🪟 Guía de Windows - Ejecutar Deber 1

Esta guía está pensada específicamente para usuarios de **Windows** que quieren ejecutar la aplicación.

---

## ✅ Requisitos

- **Docker Desktop para Windows** (versión más reciente)
- **WSL 2** (Windows Subsystem for Linux 2) - Se instala con Docker Desktop
- Una conexión a Internet

---

## 📥 Paso 1: Instalar Docker Desktop

1. Descarga [Docker Desktop para Windows](https://www.docker.com/products/docker-desktop/) desde el sitio oficial
2. Ejecuta el instalador `.exe`
3. Durante la instalación:
   - ✅ Activar "WSL 2 Based Engine"
   - ✅ Activar "Install required Windows components for WSL 2"
4. Reinicia tu computadora cuando se solicite
5. Docker Desktop se iniciará automáticamente

### Verificar la instalación

Abre **PowerShell** y ejecuta:

```powershell
docker --version
docker compose version
```

Deberías ver algo como:
```
Docker version 25.0.1, build 1a576c2
Docker Compose version v2.24.0
```

---

## 🎯 Paso 2: Descargar el Proyecto

Tienes dos opciones:

### Opción A: Con Git (Recomendado)

```powershell
git clone https://github.com/tu-usuario/deber1.git
cd deber1
```

### Opción B: Descargar ZIP

1. Ve al repositorio en GitHub
2. Haz clic en **Code → Download ZIP**
3. Extrae el archivo en una carpeta
4. Abre PowerShell en esa carpeta (clic derecho → "Open in Terminal")

---

## 🚀 Paso 3: Ejecutar la Aplicación

### Método 1: Usando Docker Compose Directamente (Más Simple)

```powershell
# Cambiar a la carpeta del proyecto
cd ./ruta/al/proyecto/deber1

# Descargar las imágenes más recientes
docker compose pull

# Iniciar los contenedores
docker compose up -d
```

**Salida esperada:**
```
[+] Running 3/3
 ✔ Network deber1_default    Created   0.0s
 ✔ Container rest-container  Healthy   10.8s
 ✔ Container jsf-container   Started   10.8s
```

### Método 2: Usando PowerShell (Si lo prefieres)

```powershell
# Ver estado de los contenedores
docker ps

# Ver logs en tiempo real
docker compose logs -f
```

---

## 🌐 Paso 4: Acceder a la Aplicación

Después de esperar **15-30 segundos**, abre en tu navegador favorito:

### ✨ Interfaz Web (JSF)
- **URL:** [http://localhost:8080](http://localhost:8080)
- Verás un botón "Call Rest"
- Haz clic para llamar al servicio REST backend

### 🔧 API REST (Endpoint directo)
- **URL:** [http://localhost:8081/api/saludo](http://localhost:8081/api/saludo)
- Verás: `Hello World desde el contenedor REST`

---

## 🛑 Paso 5: Detener la Aplicación

Cuando termines, para en PowerShell:

```powershell
docker compose down
```

---

## 🧪 Pruebas Rápidas

### Probar REST desde PowerShell

```powershell
curl http://localhost:8081/api/saludo
```

Deberías recibir: `Hello World desde el contenedor REST`

### Ver logs de los contenedores

```powershell
# Todos los logs
docker compose logs

# Solo logs de REST
docker compose logs rest-service

# Logs en tiempo real
docker compose logs -f
```

### Ver qué contenedores están ejecutándose

```powershell
docker ps
```

---

## 🐛 Troubleshooting

### ❌ Error: "Couldn't connect to Docker daemon"

**Solución:**
1. Docker Desktop no está abierto
2. Ve al menú Inicio → Busca "Docker Desktop"
3. Haz clic para abrirlo
4. Espera a que aparezca en la bandeja del sistema

### ❌ Error: "Port 8080 already in use"

Otro programa usa ese puerto. **Soluciones:**

**Opción 1:** Encontrar y cerrar el programa que usa el puerto

```powershell
# Encontrar qué usa el puerto 8080
netstat -ano | findstr :8080

# Ver qué proceso es (reemplaza PID)
tasklist | findstr PID
```

**Opción 2:** Cambiar puertos en `docker-compose.yml`

Abre el archivo y cambia:

```yaml
services:
  jsf-service:
    ports:
      - "9090:8080"  # Cambiar 8080 a 9090

  rest-service:
    ports:
      - "9091:8080"  # Cambiar 8081 a 9091
```

Luego accede a:
- JSF: http://localhost:9090
- REST: http://localhost:9091/api/saludo

### ❌ Error: "WSL 2 is not installed"

Docker necesita WSL 2. **Solución:**

```powershell
# Como administrador, abre PowerShell y ejecuta:
wsl --install

# Reinicia tu computadora
# Selecciona Ubuntu cuando se pida
# Crea un usuario para WSL
```

### ❌ Las páginas no cargan (timeout)

**Posible causa:** WildFly sigue iniciando

**Solución:** Espera 30 segundos y luego:

```powershell
# Ver logs de JSF
docker compose logs jsf-service

# Busca la línea: "Deployed ROOT.war"
```

---

## 📊 Estado de la Aplicación

Para ver si todo está funcionando correctamente:

```powershell
# 1. Verificar contenedores
docker ps

# 2. Verificar REST
curl http://localhost:8081/api/saludo

# 3. Verificar JSF (en navegador)
# Abre http://localhost:8080/
# Haz clic en "Call Rest"
# Deberías ver el mensaje de REST
```

---

## 🧹 Limpiar Todo

Si quieres desinstalar y empezar de nuevo:

```powershell
# Detener contenedores
docker compose down

# Eliminar imágenes
docker rmi byandyx/deber1-rest-server:latest
docker rmi byandyx/deber1-jsf-server:latest

# Luego, si lo deseas:
# Desinstala Docker Desktop desde "Programas y características"
```

---

## 📱 Notas para Windows

✅ **Ventajas de Docker Desktop en Windows:**
- Interfaz gráfica fácil de usar
- WSL 2 integrado
- Actualizaciones automáticas
- Fácil de probar

✅ **Sistema de archivos:**
- Los contenedores acceden a tus archivos desde `C:\Users\...`
- Mejor rendimiento si el proyecto está en el drive C:

✅ **Performance:**
- Si es lento, ve a Docker Settings → Resources
- Aumenta CPUs y Memory asignados

---

## 🆘 ¿Problemas?

### Opción 1: Ver logs completos

```powershell
docker compose logs --tail=100 -f
```

### Opción 2: Reiniciar Docker Desktop

1. Abre Docker Desktop
2. Haz clic en el icono de engranaje (Settings)
3. Ve a "Troubleshoot"
4. Haz clic en "Restart Docker Desktop"

### Opción 3: Pedir ayuda

Proporciona:
```powershell
# Screenshot de:
docker --version
docker compose version
docker ps
docker compose logs
```

---

## ✨ Próximos Pasos

Una vez que todo funciona:

1. **Probar JSF:** Abre http://localhost:8080 y haz clic en "Call Rest"
2. **Probar REST:** Abre http://localhost:8081/api/saludo en el navegador
3. **Ver cambios en tiempo real:** Edita el código y recompila si es necesario
4. **Compartir con evaluadores:** Envía solo el archivo `docker-compose.yml`

---

**¿Listo?** Ejecuta:

```powershell
docker compose up -d
```

¡Debería estar funcionando! 🎉
