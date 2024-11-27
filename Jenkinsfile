pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/antojeffrey29/jenkins-ci-cd.git'
            }
        }
        stage('Initialize Terraform') {
            steps {
                bat 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }
        stage('Approve Apply') {
            steps {
                script {
                    // Prompt user for confirmation
                    input message: 'Do you want to proceed with `terraform apply`?', ok: 'Yes, proceed', timeout:3
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                bat 'terraform apply -auto-approve tfplan'
            }
        }
        stage('Wait for 3 Minutes') {
            steps {
                script {
                    sleep(time: 3, unit: 'MINUTES') // Wait for 3 minutes
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                bat 'terraform destroy -auto-approve'
            }
        }
    }
    post {
        always {
            cleanWs() // Cleans up the workspace
        }
    }
}