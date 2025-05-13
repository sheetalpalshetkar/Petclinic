pipeline {
    agent any

    environment {
        IMAGE_NAME = 'pet-clinic-app'
        CONTAINER_NAME = 'pet-clinic-container'
    }

    stages {
        stage('Checkout') {
            steps {
                // Replace with your actual GitHub repo and branch
                git branch: 'main', url: 'https://github.com/sheetalpalshetkar/Petclinic.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the Project with Maven compile'
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
                echo 'Building Docker Image'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Docker Container'
                // Stop existing container if any
                sh "docker rm -f ${CONTAINER_NAME} || true"
                // Start container
                sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}"
            }
        }
    }
}
