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

deploy() {
    printer "🚀 Deploying the app"
    cp -r app SquareCode
    rm -f SquareCode/app/.gitattributes
    rm -f SquareCode/app/README.md
    cp app/.gitattributes SquareCode
    cp app/README.md SquareCode
    cp -r .gitignore SquareCode
    cp -r Dockerfile SquareCode
    cd SquareCode
    git add .
    git commit -m "Deployed the app"
    git push
    cd ..
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
