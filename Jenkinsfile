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
                git branch: 'master', credentialsId: 'A', url: 'git@github.com:Ajay1672/Docker-Jenkins-Java-Application.git'
            }
        }

        stage('Clean') {
            steps {
                dir('WebApp') {  
                    sh 'mvn clean'
                }
            }
        }

        stage('Package') {
            steps {
                dir('WebApp') {  
                    sh 'mvn package'
                }
            }
        }
    }
}
