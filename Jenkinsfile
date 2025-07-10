pipeline {
    agent any
    environment {
        DOCKER_IMAGE='grpcdata'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build --no-cache -t $DOCKER_IMAGE .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run --rm $DOCKER_IMAGE'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm $DOCKER_IMAGE'
            }
        }
        stage('Lint') {
            steps {
                sh "docker run --rm -w /app $DOCKER_IMAGE clang-tidy src/vehicle_controller.cpp -- -I/app/src/ -std=c++11"
            }
        }
        stage('Push to Dockerhub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh """
                        echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                        docker tag $DOCKER_IMAGE $DOCKERHUB_USER/$DOCKER_IMAGE:latest
                        docker push $DOCKERHUB_USER/$DOCKER_IMAGE:latest
                    """
                }
            }
        }
    }
    post {
        success {
            echo "build succeeded"
        }
        failure {
            echo "Build failed"
        }
    }
}