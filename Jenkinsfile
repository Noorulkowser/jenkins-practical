pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2'
        TF_VERSION = '1.6.0'
    }

    tools {
        terraform "${TF_VERSION}"
    }

    stages {
        stage('Checkout Terraform Code') {
            steps {
                git branch: 'main',
                   
                    url: 'https://github.com/Noorulkowser/jenkins-practical.git'
            }
        }

        stage('Setup AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '4761088f-74ea-47dc-9536-3a2f34063744
']]) {
                    sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=${AWS_REGION}
                        echo "AWS Credentials Set"
                    '''
                }
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
