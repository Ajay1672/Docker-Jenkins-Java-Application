pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'a', url: 'git@github.com:Ajay1672/Docker-Jenkins-Java-Application.git'
            }
        }

        stage('Clean') {
            steps {
                 bat 'cd WebApp && mvn clean'
            }
        }

        stage('Packages') {
            steps {
                bat 'cd WebApp && mvn package'
           
            }
        }
    }
}
