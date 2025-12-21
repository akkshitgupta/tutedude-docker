pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                echo 'Stopping and removing existing containers...'
                // Using "|| true" to prevent the pipeline from failing if containers don't exist
                sh 'docker stop td-frontend td-backend || true'
                sh 'docker rm td-frontend td-backend || true'
            }
        }

        stage('Build Images') {
            steps {
                echo 'Building Docker images...'
                sh 'docker build -t tutedude-frontend ./express-frontend/'
                sh 'docker build -t tutedude-backend ./flask-backend/'
            }
        }

        stage('Deploy Containers') {
            steps {
                echo 'Starting new containers...'
                sh 'docker run -d --name td-frontend -p 3000:3000 tutedude-frontend'
                sh 'docker run -d --name td-backend -p 8000:8000 tutedude-backend'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful! Frontend on port 3000, Backend on port 8000.'
        }
        failure {
            echo 'Deployment failed. Check docker logs for details.'
        }
    }
}