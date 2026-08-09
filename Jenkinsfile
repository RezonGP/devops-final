pipeline {
    agent any

    stages {
        stage('1. Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/RezonGP/devops-final.git'
            }
        }

        stage('2. Build Docker Images') {
            steps {
                sh 'docker compose build'
            }
        }

        stage('3. Deploy Application') {
            steps {
                sh 'docker compose up --build -d'
            }
        }
    }

    post {
        success {
            echo 'Trien khai CI/CD qua Jenkins thanh cong 100%!'
        }
        failure {
            echo 'Trien khai CI/CD bi loi, vui long kiem tra log!'
        }
    }
}
vpipeline {
    agent any

    stages {
        stage('1. Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/RezonGP/devops-final.git'
            }
        }

        stage('2. Build Docker Images') {
            steps {
                sh 'docker compose build'
            }
        }

        stage('3. Deploy Application') {
            steps {
                sh 'docker compose up --build -d'
            }
        }
    }

    post {
        success {
            echo 'Trien khai CI/CD qua Jenkins thanh cong 100%!'
        }
        failure {
            echo 'Trien khai CI/CD bi loi, vui long kiem tra log!'
        }
    }
}
