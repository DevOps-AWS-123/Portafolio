pipeline{
    agent any

    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }
        stage("Test"){
            steps{
                sh "sudo apt install npm"
                sh "npm test"
            }
        }
        stage("Deploy"){
            steps{
                sh "sudo npm run build"
            }
        }
    }
}
