#!/bin/bash

start() {
    printer "🚀 Starting the app"
    docker run --rm --name app-squarecode -p 7860:7860 app-squarecode
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
    docker run --rm --name app-squarecode -p 7860:7860 app-squarecode
    handler
}

build() {
    printer "🔧 Building the app"

    # -------------------------

    mkdir -p build
    rm -rf build/*
    cp -r app build/app
    rm -f build/app/README.md
    cp .gitattributes build
    cp .gitignore build
    cp Dockerfile build
    cp app/README.md build

    # -------------------------

    handler
}

clear() {
    printer "🧹 Clearing all"
    docker rm -f app-squarecode
    docker rmi app-squarecode
    handler
}

deploy() {
    printer "📦 Deploying the app"

    # -------------------------

    git add .
    git commit -m "Deployed the app"
    git push

    # -------------------------

    rm -rf SquareCode/*
    cp -r app SquareCode/app
    cp .gitattributes SquareCode
    cp .gitignore SquareCode
    cp Dockerfile SquareCode
    cp app/README.md SquareCode

    # -------------------------

    cd SquareCode
    git add .
    git commit -m "Deployed the app"
    git push origin main
    cd ..

    # -------------------------
    
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
    deploy)
        deploy
        ;;
    *)
        echo "Usage: $0 {start|stop|setup|build|clear|deploy}"
        ;;
esac
