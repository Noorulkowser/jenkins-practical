pipeline {
    agent any

    environment {
AWS_CREDENTIALS_ID = credentials'4761088f-74ea-47dc-9536-3a2f34063744
'  // Replace with actual AWS credential ID
    }

    stages {
        stage('Checkout Terraform Code') {
            steps {
                git branch: 'main',
                   
                    url: 'https://github.com/Noorulkowser/jenkins-practical.git'
            }
        }

       

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Do you want to apply Terraform changes?"
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
    }
}
