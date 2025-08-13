#!/bin/bash

VENV_DIR="venv"

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
    python -m venv $VENV_DIR
    source $VENV_DIR/bin/activate
    pip install --upgrade pip
    git submodule update --init --recursive
    docker build -t app-squarecode .
    docker run --rm --name app-squarecode -p 7860:7860 app-squarecode
    handler
}

build() {
    printer "🔧 Building the app"
    mkdir -p build
    rm -rf build/*
    cp -r app build/app
    rm -f build/app/README.md
    cp .gitattributes build
    cp .gitignore build
    cp Dockerfile build
    cp app/README.md build
    handler
}

clear() {
    printer "🧹 Clearing all"
    rm -rf $VENV_DIR
    docker rm -f app-squarecode
    docker rmi app-squarecode
    handler
}

deploy() {
    printer "📦 Deploying the app"
    rm -rf squarecode/*
    cp -r app squarecode/app
    cp .gitattributes squarecode
    cp .gitignore squarecode
    cp Dockerfile squarecode
    cp app/README.md squarecode
    cd squarecode
    git checkout main
    git add .
    git commit -m "Deployed the app"
    git push
    cd ..
    git checkout main
    git submodule update --remote
    git add .
    git commit -m "Deployed the app"
    git push
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
