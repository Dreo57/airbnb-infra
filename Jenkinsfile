def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning project codebase'
                git branch: 'main', url: 'https://github.com/Dreo57/airbnb-infra.git'
                sh 'ls'
            }
        }
        stage('Verify Terrafom Version') {
            steps {
                echo 'Verifying the terraform version'
                sh 'terraform --version'
            }
        }
        stage('Terraform initialization') {
            steps {
                echo 'Initializing terraform'
                sh 'terraform init'
            }
        }
        stage('Terraform validate') {
            steps {
                echo 'Code syntax check'
                sh 'terraform validate'
            }
        }
        stage('Terraform plan') {
            steps {
                echo 'Terraform plan'
                sh 'terraform plan'
            }
        }
        stage('Checkov Scan') {
            steps {
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS_79
                """
            }
        }
        stage('Manual Approval') {
            steps {
                input 'Approval required for deployment'
            }
        }
        stage('Terraform apply') {
            steps {
                echo 'Terraform apply'
                sh 'sudo terraform apply --auto-approve'
            }
        }
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
                slackSend channel: '#glorious-w-f-devops-alerts', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}
