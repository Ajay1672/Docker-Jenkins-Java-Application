pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }

         stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'a', url: 'git@github.com:Ajay1672/Docker-Java-Project.git'
            }
        }

       stage('clean') {
            steps {
                bat 'cd webApp1 && mvn clean'
            }
        }

         stage('Package') {
            steps {
                bat 'cd webApp1 && mvn package'
            }
        }

        stage('Package') {
            steps {
                def nexusURL="http://localhost:8081/"
            }
        }
    }
}
