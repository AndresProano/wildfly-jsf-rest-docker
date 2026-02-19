#!/bin/bash

# Script helper para gestionar la aplicación Deber 1
# Uso: ./deber1.sh [comando]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_USER="byandyx"  # Cambiar por tu usuario

print_usage() {
    echo "╔════════════════════════════════════════════════════╗"
    echo "║       Deber 1 - Jakarta EE + WildFly + Docker     ║"
    echo "╚════════════════════════════════════════════════════╝"
    echo ""
    echo "Uso: ./deber1.sh [comando]"
    echo ""
    echo "Comandos disponibles:"
    echo "  start       - Iniciar la aplicación (docker compose up -d)"
    echo "  stop        - Detener la aplicación (docker compose down)"
    echo "  logs        - Ver logs de los contenedores"
    echo "  status      - Ver estado de los contenedores"
    echo "  restart     - Reiniciar la aplicación"
    echo "  pull        - Descargar imágenes más recientes"
    echo "  build       - Compilar WARs con Maven (requiere Java 17+)"
    echo "  push        - Compilar y subir imágenes a Docker Hub"
    echo "  test-rest   - Probar endpoint REST"
    echo "  test-web    - Probar interfaz JSF"
    echo "  clean       - Detener y limpiar todo"
    echo "  help        - Mostrar este mensaje"
    echo ""
}

start() {
    echo "▶️  Iniciando aplicación..."
    cd "$SCRIPT_DIR"
    docker compose pull
    docker compose up -d
    echo "✅ Aplicación iniciada!"
    echo ""
    echo "🌐 Recursos disponibles:"
    echo "   REST API:    http://localhost:8081/api/saludo"
    echo "   JSF Web:     http://localhost:8080/"
}

stop() {
    echo "⏹️  Deteniendo aplicación..."
    cd "$SCRIPT_DIR"
    docker compose down
    echo "✅ Aplicación detenida!"
}

logs() {
    cd "$SCRIPT_DIR"
    docker compose logs -f
}

status() {
    cd "$SCRIPT_DIR"
    echo "Estado de los contenedores:"
    docker compose ps
}

restart() {
    echo "🔄 Reiniciando aplicación..."
    stop
    start
}

pull() {
    echo "📥 Descargando imágenes..."
    cd "$SCRIPT_DIR"
    docker compose pull
    echo "✅ Imágenes descargadas!"
}

build() {
    echo "🔨 Compilando WARs con Maven..."
    cd "$SCRIPT_DIR"
    mvn -f app-rest/pom.xml clean package -DskipTests
    mvn -f app-jsf/pom.xml clean package -DskipTests
    echo "✅ WARs compilados!"
}

push() {
    echo "🏗️  Compilando y subiendo imágenes a Docker Hub..."
    echo "Usuario Docker Hub: $DOCKER_USER"
    echo ""
    
    if ! command -v docker buildx &> /dev/null; then
        echo "❌ docker buildx no está disponible"
        echo "Instalando buildx..."
    fi
    
    cd "$SCRIPT_DIR"
    
    # Compilar primero
    echo "📦 Compilando WARs..."
    mvn -f app-rest/pom.xml clean package -DskipTests
    mvn -f app-jsf/pom.xml clean package -DskipTests
    
    # Crear builder si no existe
    docker buildx create --name multiarch-builder --use 2>/dev/null || \
    docker buildx use multiarch-builder
    
    echo ""
    echo "🚀 Compilando y subiendo REST..."
    docker buildx build --platform linux/amd64,linux/arm64 \
      -t "$DOCKER_USER/deber1-rest-server:latest" \
      -f app-rest/Dockerfile . --push
    
    echo ""
    echo "🚀 Compilando y subiendo JSF..."
    docker buildx build --platform linux/amd64,linux/arm64 \
      -t "$DOCKER_USER/deber1-jsf-server:latest" \
      -f app-jsf/Dockerfile . --push
    
    echo "✅ ¡Imágenes subidas a Docker Hub!"
}

test_rest() {
    echo "🧪 Probando API REST..."
    echo ""
    curl -s http://localhost:8081/api/saludo
    echo ""
    echo ""
    echo "✅ Si ves 'Hello World desde el contenedor REST', está funcionando!"
}

test_web() {
    echo "🧪 Probando interfaz JSF..."
    echo "Abre en tu navegador: http://localhost:8080/"
    echo ""
    
    if command -v open &> /dev/null; then
        open http://localhost:8080/
    elif command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:8080/
    elif command -v start &> /dev/null; then
        start http://localhost:8080/
    else
        echo "Abre manualmente en tu navegador: http://localhost:8080/"
    fi
}

clean() {
    echo "🧹 Limpiando todo..."
    cd "$SCRIPT_DIR"
    docker compose down -v
    docker rmi "$DOCKER_USER/deber1-rest-server:latest" 2>/dev/null || true
    docker rmi "$DOCKER_USER/deber1-jsf-server:latest" 2>/dev/null || true
    echo "✅ ¡Limpieza completada!"
}

# Ejecutar comando
case "${1:-help}" in
    start)   start ;;
    stop)    stop ;;
    logs)    logs ;;
    status)  status ;;
    restart) restart ;;
    pull)    pull ;;
    build)   build ;;
    push)    push ;;
    test-rest) test_rest ;;
    test-web)  test_web ;;
    clean)   clean ;;
    help|*)  print_usage ;;
esac
