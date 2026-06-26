pipeline {

    agent any

    environment {
        DOCKER_USERNAME = "ranjith02987"
        IMAGE_NAME = "ecommerce-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                chmod +x build.sh
                ./build.sh ${IMAGE_NAME} latest
                '''
            }
        }

        stage('Push DEV Image') {
            when {
                branch 'dev'
            }

            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                    docker tag ${IMAGE_NAME}:latest ${DOCKER_USERNAME}/dev:latest

                    docker push ${DOCKER_USERNAME}/dev:latest
                    '''
                }
            }
        }

        stage('Push PROD Image') {

            when {
                branch 'master'
            }

            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''

                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                    docker tag ${IMAGE_NAME}:latest ${DOCKER_USERNAME}/prod:latest

                    docker push ${DOCKER_USERNAME}/prod:latest

                    '''
                }
            }
        }

        stage('Deploy Production') {

            when {
                branch 'master'
            }

            steps {

                sh '''

                chmod +x deploy.sh

                ./deploy.sh ${DOCKER_USERNAME}/prod latest

                '''
            }
        }

    }

}   