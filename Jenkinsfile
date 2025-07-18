pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2' // Default region, can be overridden per branch
        TERRAFORM_DIR = 'terraform' // Path to your Terraform code
    }

    options {
        ansiColor('xterm')
        skipDefaultCheckout()
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform init -backend=false'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Format Check') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform fmt -check -diff'
                }
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '4761088f-74ea-47dc-9536-3a2f34063744']]) {
                    dir("${env.TERRAFORM_DIR}") {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            terraform init
                            terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                allOf {
                    branch 'main'
                    expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                }
            }
            steps {
                input message: 'Apply infrastructure changes?'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    dir("${env.TERRAFORM_DIR}") {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS
