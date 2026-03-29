pipeline {
    agent any

    environment {
        PUBLIC_IP = "13.218.248.219"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/pradeepbani/Auto-deploy.git'
            }
        }

        stage('Prepare Inventory') {
            steps {
                sh '''
                echo "[web]" > ansible/inventory
                echo "$PUBLIC_IP ansible_user=ec2-user ansible_ssh_private_key_file=/var/lib/jenkins/devops-key.pem" >> ansible/inventory
                '''
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sh 'cd ansible && ansible-playbook -i inventory install_nginx.yml'
            }
        }
    }
}