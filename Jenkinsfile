pipeline {
    agent any

    environment {
        PATH = "/opt/homebrew/bin:/usr/local/bin:${env.PATH}"
        REGISTRY = 'docker.io/ishika979'
        aws_access_key = credentials('aws-access-key')
        aws_secret_key = credentials('aws-secret-key')
    }

    options {
        skipDefaultCheckout true
    }

    stages {
        stage('Pull stage') {
            steps {
                git url: 'https://github.com/Ishikapbhatt/MDA4.git', branch: 'main'
            }
        }

        stage('Infrastructure') {
            steps {
                dir('Terraform/eks-modules') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
                sh 'aws eks update-kubeconfig --name my-eks-cluster --region us-west-2'
            }
        }

        stage('Build') {
            steps {
                dir('docker/studentapp/database') {
                    sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest --load .'
                }
                dir('docker/studentapp/backend') {
                    sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest --load .'
                }
                dir('docker/studentapp/frontend') {
                    sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest --load .'
                }
            }
        }

        stage('Push stage') {
            steps {
                sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest --push docker/studentapp/database'
                sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest --push docker/studentapp/backend'
                sh 'docker buildx build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest --push docker/studentapp/frontend'
            }
        }

        stage('Deploy') {
            steps {
                dir('KUbernetes/Studentapp') {
                    sh 'kubectl apply -f Database/'
                    sh 'kubectl apply -f Backend/'
                    sh 'kubectl apply -f Frontend/'
                }
            }
        }
    }
}