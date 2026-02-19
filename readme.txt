DEBER 1
Aplicación Distribuida con Jakarta EE, WildFly 37 y Docker
Integrantes del grupo

Pablo Alvarado
Desarrollo de la aplicación JSF, implementación del CDI Bean que consume el servicio REST, configuración de Docker Compose y pruebas de integración entre contenedores.

Andrés Proaño
Desarrollo de la aplicación REST con JAX-RS, configuración de WildFly 37.0.0.Final, creación de imágenes Docker y verificación del despliegue en contenedores.

Descripción del proyecto

Este proyecto implementa dos aplicaciones independientes desplegadas en contenedores Docker utilizando WildFly 37.0.0.Final:

Aplicación REST (app-rest)
Expone un endpoint JAX-RS en:
/app-rest/api/saludo
que retorna un mensaje de texto.

Aplicación JSF (app-jsf)
Presenta una página web con un botón.
Al hacer clic:

Un CDI Bean envía una petición HTTP al servicio REST.

Recibe la respuesta.

Muestra el mensaje en la interfaz web.

Ambas aplicaciones se ejecutan en contenedores separados y se comunican a través de la red interna de Docker Compose.

Tecnologías utilizadas

Jakarta EE 10

WildFly 37.0.0.Final

Java 17

Maven

Docker

Docker Compose

Estructura del proyecto

app-rest/ → Aplicación REST (WAR: app-rest.war)

app-jsf/ → Aplicación JSF (WAR: app-jsf.war)

docker-compose.yml → Orquestación de contenedores

docker-compose-build.yml → Archivo de referencia para build local

🚀 EJECUCIÓN DESDE DOCKER HUB (RECOMENDADO)

Este es el procedimiento que cumple exactamente el requisito del deber: descargar imágenes y ejecutarlas.

Requisitos

Docker

Docker Compose

Verificar instalación:

docker version
docker compose version

Paso 1 – Descargar imágenes
docker compose pull

Paso 2 – Ejecutar contenedores
docker compose up

URLs de prueba
Servicio REST

http://localhost:8081/app-rest/api/saludo

Debería mostrar:

Hello World desde el contenedor REST

Aplicación JSF

http://localhost:8080/app-jsf/

Abrir en el navegador

Hacer clic en el botón

Se mostrará el mensaje proveniente del servicio REST

Orden de arranque de contenedores

Docker Compose garantiza que:

El contenedor REST se inicie primero.

El contenedor JSF solo se inicie cuando el REST esté disponible (usando depends_on con healthcheck).

Esto cumple el requisito solicitado en el deber.

🛠 EJECUCIÓN CON BUILD LOCAL (OPCIONAL)

Si se desea compilar el proyecto desde el código fuente:

Compilar WARs
mvn -f app-rest/pom.xml clean package
mvn -f app-jsf/pom.xml clean package

Construir imágenes y ejecutar
docker compose -f docker-compose-build.yml build
docker compose -f docker-compose-build.yml up

🧪 Pruebas por consola

Prueba del servicio REST:

curl http://localhost:8081/app-rest/api/saludo

🔁 Limpieza completa (opcional)

Para reiniciar todo desde cero:

docker compose down --volumes --remove-orphans
docker compose pull
docker compose up

✅ Cumplimiento de requisitos del deber

✔ Uso de WildFly 37.0.0.Final
✔ Dos aplicaciones independientes (JSF y REST)
✔ Comunicación entre contenedores
✔ Uso de Docker Compose
✔ REST inicia antes que JSF
✔ Imágenes subidas a Docker Hub
✔ Instrucciones claras para descarga y ejecución