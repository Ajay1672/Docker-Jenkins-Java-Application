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
                git branch: 'master', credentialsId: 'a', url: 'git@github.com:Ajay1672/Docker-Jenkins-Java-Application.git'
            }
        }

        stage('Clean') {
            steps {
                // dir('WebApp') {  
                //     sh 'mvn clean'
                // }/
                bat 'cd WebApp && mvn clean'
            }
        }

        stage('Packages') {
            steps {
                // dir('WebApp') {  
                //     sh 'mvn package'
                // }
            

                bat 'cd WebApp && mvn package'
            }
        }
    }
}
