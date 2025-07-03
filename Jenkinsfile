pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build --no-cache -t grpcdata .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run --rm grpcdata'
            }
        }
        stage('Test') {
            steps {
                sh 'make test'
            }
        }
        stage('Lint') {
            steps {
                sh 'clang-tidy'
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
                        docker tag grpcdata $DOCKERHUB_USER/grpcdata:latest
                        docker push $DOCKERHUB_USER/grpcdata:latest
                    """
                }
            }
        }
    }
}