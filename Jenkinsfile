pipeline {
    agent any
        
    tools {
        nodejs 'node' // Use the name you configured in Jenkins
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('cred') // ID for DockerHub credentials stored in Jenkins
        DOCKER_IMAGE = "rajnages/portafolia-website"  // DockerHub image name
        VERSION = "latest"  // Can be dynamically set to Git commit, tag, or version number
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from your repository
                git branch: 'master', url: 'https://github.com/DevOps-AWS-123/Portafolio.git'
            }
        }

        stage('Build Application') {
            steps {
                // Install dependencies and build the Node.js application
                sh 'npm install'
                sh 'npm run build'  // Adjust based on your build process
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${VERSION} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to DockerHub and push the image
                    sh "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
                    sh "docker push ${DOCKER_IMAGE}:${VERSION}"
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    // Optional: Deploy the new Docker image to a server (you can use SSH, Ansible, etc.)
                    // Example with SSH to a server to update the running container:
                    sshagent(['server-credentials']) {
                        sh """
                        ssh user@your-server 'docker pull ${DOCKER_IMAGE}:${VERSION} && docker stop app_container || true && docker rm app_container || true && docker run -d --name app_container -p 80:80 ${DOCKER_IMAGE}:${VERSION}'
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace and remove the Docker image locally
            sh 'docker rmi ${DOCKER_IMAGE}:${VERSION}'
            cleanWs()
        }
    }
}
