pipeline {
    agent any

    environment {
        IMAGE_NAME = 'pet-clinic-app'
        CONTAINER_NAME = 'pet-clinic-container'
    }

    stages {
        stage('Verify Environment') {
            steps {
                echo 'Verifying Jenkins environment...'
                sh 'whoami'
                sh 'docker --version'
                sh 'git --version'
                sh 'java -version || true'
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sheetalpalshetkar/Petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image from Dockerfile...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo 'Stopping previous containers and deploying...'
                sh 'docker-compose down || true'
                sh 'docker-compose up -d --build'

                echo 'Waiting for MySQL to be ready...'
                sh '''
                for i in {1..10}; do
                    nc -z mysql 3306 && echo "MySQL is up" && break
                    echo "Waiting for MySQL..."
                    sleep 5
                done
                '''
            }
        }
    }
}
