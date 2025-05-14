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
                sh 'java -version'
                sh './mvnw -v || mvn -v'
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sheetalpalshetkar/Petclinic.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the Project with Maven compile'
                sh 'chmod +x mvnw'
                sh './mvnw clean compile'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing the Project with Maven test'
                sh './mvnw test'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the Project with Maven package'
                sh './mvnw package'
            }
        }

        stage('Containerize') {
            steps {
                echo 'Cleaning up old Docker artifacts...'
                sh 'docker rm -f ${CONTAINER_NAME} || true'
                sh 'docker rmi -f ${IMAGE_NAME} || true'

                echo 'Building Docker Image...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Docker Container...'
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}'
            }
        }
    }
}
