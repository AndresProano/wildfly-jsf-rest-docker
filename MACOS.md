# 🍎 Guía de macOS - Ejecutar Deber 1

Esta guía está pensada específicamente para usuarios de **Mac** (Intel y Apple Silicon) que quieren ejecutar la aplicación.

---

## ✅ Requisitos

- **Docker Desktop para Mac** (versión más reciente)
- **macOS 11+** (Big Sur o más nuevo)
- Una conexión a Internet

---

## 📥 Paso 1: Instalar Docker Desktop

### Para Mac Intel o Apple Silicon

1. Descarga [Docker Desktop para Mac](https://www.docker.com/products/docker-desktop/) desde el sitio oficial
   - Elige **Apple Silicon (M1/M2/M3)** si tienes Mac nuevo
   - Elige **Intel Chip** si tienes Mac más antiguo

2. Abre el archivo `.dmg` descargado
3. Arrastra el icono Docker a la carpeta Applications
4. Abre **Applications → Docker.app**
5. Docker se iniciará automáticamente (verás el icono en el menu bar)

### Verificar la instalación

Abre Terminal y ejecuta:

```bash
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

```bash
git clone https://github.com/tu-usuario/deber1.git
cd deber1
```

### Opción B: Descargar ZIP

1. Ve al repositorio en GitHub
2. Haz clic en **Code → Download ZIP**
3. Extrae el archivo en una carpeta
4. Abre Terminal en esa carpeta (Cmd+Space, escribe "terminal", abre)
5. Navega con `cd` a la carpeta extraída

---

## 🚀 Paso 3: Ejecutar la Aplicación

### Método 1: Comando Simple (Recomendado)

En Terminal, cambia a la carpeta del proyecto y ejecuta:

```bash
# Descargar las imágenes más recientes
docker compose pull

# Iniciar los contenedores en segundo plano
docker compose up -d
```

**Salida esperada:**
```
[+] Running 3/3
 ✔ Network deber1_default    Created   0.0s
 ✔ Container rest-container  Healthy   10.8s
 ✔ Container jsf-container   Started   10.8s
```

### Método 2: Con el Script Helper (Si existe)

```bash
# Hacer el script ejecutable (solo primera vez)
chmod +x deber1.sh

# Iniciar
./deber1.sh start

# Ver logs
./deber1.sh logs

# Detener
./deber1.sh stop
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

Cuando termines, en Terminal:

```bash
docker compose down
```

O si usas el script:

```bash
./deber1.sh stop
```

---

## 🧪 Pruebas Rápidas

### Probar REST desde Terminal

```bash
curl http://localhost:8081/api/saludo
```

Deberías recibir: `Hello World desde el contenedor REST`

### Ver logs en tiempo real

```bash
docker compose logs -f
```

### Ver qué contenedores están ejecutándose

```bash
docker ps
```

### Ver logs de un servicio específico

```bash
docker compose logs rest-service
docker compose logs jsf-service
```

---

## 🐛 Troubleshooting

### ❌ Error: "Couldn't connect to Docker daemon"

**Solución:**
1. Docker Desktop no está abierto
2. Ve a Applications → Docker
3. O busca Docker en Spotlight (Cmd+Space) y abre

### ❌ Error: "Port 8080 already in use"

Otro programa usa ese puerto. **Soluciones:**

**Opción 1:** Encontrar y cerrar el programa que usa el puerto

```bash
# Ver qué usa el puerto 8080
lsof -i :8080

# Ver proceso completo
ps aux | grep [proceso]

# Matar el proceso (reemplaza PID)
kill -9 PID
```

**Opción 2:** Cambiar puertos en `docker-compose.yml`

Abre el archivo con tu editor favorito y cambia:

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

### ❌ Las páginas no cargan (timeout)

**Posible causa:** WildFly sigue iniciando

**Solución:** Espera 30 segundos y luego:

```bash
# Ver logs de JSF
docker compose logs jsf-service

# Busca la línea: "Deployed ROOT.war"
```

### ❌ Error de memoria en Mac con Apple Silicon

Si la aplicación va muito lenta:

```bash
# Abre Docker Desktop → Settings → Resources
# Aumenta CPU y Memory
# Aplica cambios
```

---

## 📊 Estado de la Aplicación

Para ver si todo está funcionando correctamente:

```bash
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

```bash
# Detener y limpiar contenedores
docker compose down -v

# Eliminar imágenes
docker rmi byandyx/deber1-rest-server:latest
docker rmi byandyx/deber1-jsf-server:latest

# Luego, si lo deseas:
# Desinstala Docker Desktop desde Applications
```

---

## 🚀 Tips para Mac

### ✅ Apple Silicon (M1/M2/M3)

La aplicación está optimizada para tu arquitectura:
```bash
# Verifica que Docker está usando la arquitectura correcta
docker version | grep Architecture
# Debería mostrar: arm64
```

### ✅ Rendimiento

Para mejor rendimiento en Mac:

1. **Docker Desktop Settings:**
   - Resources → Aumenta CPUs (4+) y Memory (4GB+)
   - Disk image location → Almacenamiento rápido

2. **Terminal nativa:**
   - Usa Terminal.app en lugar de iTerm2 para mejor integración

3. **Hot reload (si compilas localmente):**
   ```bash
   # Compartir carpeta con contenedor (en docker-compose.yml)
   volumes:
     - ./app-rest/target/app-rest.war:/opt/jboss/wildfly/standalone/deployments/ROOT.war
   ```

### ✅ Atajos útiles

Crea alias en tu `~/.zshrc` o `~/.bash_profile`:

```bash
# Agregar al final del archivo
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
```

Luego:
```bash
# Recargar shell
source ~/.zshrc

# Usar atajos
dcu  # levanta
dcd  # baja
dcl  # logs
```

---

## 🆘 ¿Problemas?

### Opción 1: Ver logs completos

```bash
docker compose logs --tail=100 -f
```

### Opción 2: Reiniciar Docker Desktop

1. Abre Docker Desktop
2. Haz clic en el icono Docker en el menu bar
3. Elige "Quit Docker Desktop"
4. Espera a que se cierre
5. Vuelve a abrirlo desde Applications

### Opción 3: Pedir ayuda

Proporciona:
```bash
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
3. **Compilar cambios (si desarrollas):**
   ```bash
   mvn -f app-rest/pom.xml clean package
   mvn -f app-jsf/pom.xml clean package
   ./deber1.sh push  # Subir a Docker Hub (requiere cuenta)
   ```
4. **Compartir con evaluadores:** Envía solo:
   - `docker-compose.yml`
   - Este archivo de documentación

---

**¿Listo?** Ejecuta en Terminal:

```bash
docker compose up -d
```

¡Debería estar funcionando! 🎉

---

## 📚 Referencias útiles para Mac

- [Docker Desktop para Mac - Documentación oficial](https://docs.docker.com/desktop/install/mac-install/)
- [Troubleshooting Docker en Mac](https://docs.docker.com/desktop/mac/troubleshoot/)
- [Optimizar Docker Desktop para Mac](https://docs.docker.com/desktop/mac/resource-saver/)
