pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t grpcdata .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run --rm grpcdata'
            }
        }
    }
}