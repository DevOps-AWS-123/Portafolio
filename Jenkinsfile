pipeline {
    agent any

    options {
        timeout(time: 1, unit: 'HOURS') // Set a global timeout
        retry(3) // Retry the pipeline 3 times in case of failure
    }

    environment {
        NODE_HOME = '/usr/bin/node'
        PATH = "${env.PATH}:${NODE_HOME}/bin"
    }

    tools {
        nodejs "NodeJS" // Use NodeJS from Jenkins tools
    }

    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Install Dependencies") {
            steps {
                // Cache node_modules to speed up build time
                cache(path: './node_modules', key: 'npm-dependencies') {
                    sh "npm install"
                }
            }
        }

        stage("Test") {
            steps {
                sh "npm test"
            }
        }

        stage("Build") {
            steps {
                sh "npm run build"
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'Build and tests succeeded!'
        }
        failure {
            echo 'Build or test failed'
        }
        // Optionally, you can enable email notifications here.
        // failure {
        //     mail to: 'team@example.com',
        //          subject: "Pipeline Failed: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
        //          body: "Check Jenkins for more details: ${env.BUILD_URL}"
        // }
    }
}
