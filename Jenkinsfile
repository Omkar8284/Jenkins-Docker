pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Omkar8284/Jenkins-Docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("omkar8284/jenkins-demo:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-creds') {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Node2') {
            steps {
                sshagent(['jenkins-ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no omkar@192.168.152.129 "
                            docker pull omkar8284/jenkins-demo:latest &&
                            docker stop demo-app || true &&
                            docker rm demo-app || true &&
                            docker run -d -p 80:80 --name demo-app omkar8284/jenkins-demo:latest

                        "
                    '''
                }
            }
        }

    }
}
