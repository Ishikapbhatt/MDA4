    pipeline {
        agent any
        
        stages {
            stage "Pull stage" {
                steps {
                    sh 'git clone https://github.com/Ishikapbhatt/MDA4.git'
                }
            }

            stage "Infrastructure" {
                steps {
                    sh 'cd Terraform/eks-modules'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }

            stage "Build" {
                steps {
                    sh 'cd docker/student-app/database'
                    sh 'docker build -t studentapp-db .'
                    sh 'cd ../backend'
                    sh 'docker build -t studentapp-be .'
                    sh 'cd ../frontend'
                    sh 'docker build -t studentapp-fe .'
                }
            }

            stage "push stage" {
                steps {
                    sh 'docker push studentapp-db'
                    sh 'docker push studentapp-be'
                    sh 'docker push studentapp-fe'
                }
            }
            
            stage "Deploy" {
                steps {
                    sh 'cd Kubernetes/student-app/'
                    sh 'kubectl apply -f KUbernetes/student-app/'
                }
            }
        }
    }