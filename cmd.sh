#!/bin/bash

start() {
    printer "🚀 Starting the app"
    docker run --name app-squarecode -p 7860:7860 app-squarecode
    handler
}

stop() {
    printer "🛑 Stopping the app"
    docker stop app-squarecode
    handler
}

setup() {
    printer "🔨 Setting up the app"
    docker build -t app-squarecode .
    docker run --name app-squarecode -p 7860:7860 app-squarecode
    handler
}

build() {
    printer "🔧 Building the app"
    mkdir build
    cp -r app build
    rm -f build/app/.gitattributes
    rm -f build/app/README.md
    cp app/.gitattributes build
    cp app/README.md build
    cp -r .gitignore build
    cp -r Dockerfile build
    handler
}

clear() {
    printer "🧹 Clearing all"
    docker rm -f app-squarecode
    docker rmi app-squarecode
    handler
}

printer() {
    echo ""
    echo $1
    echo ""
}

handler() {
    if [ $? -eq 0 ]; then
        printer "✅ Process completed successfully"
    else
        printer "❌ An error occurred during the process"
        exit 1
    fi
}

case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    setup)
        setup
        ;;
    build)
        build
        ;;
    clear)
        clear
        ;;
    *)
        echo "Usage: $0 {start|stop|setup|build|clear}"
        ;;
esac
