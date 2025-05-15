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

        stage('Containerize') {
            steps {
                echo 'Cleaning up old Docker container (if exists)...'
                sh 'docker rm -f ${CONTAINER_NAME} || true'
                sh 'docker rmi -f ${IMAGE_NAME} || true'

                echo 'Building Docker Image using multi-stage Dockerfile...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Docker container...'
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}'
            }
        }
    }
}
