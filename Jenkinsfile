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

         stage('Deployment into Nexus Repo') {
            steps {
                script {
                def nexusUrl = "http://localhost:8081/repository/java-maven-app/com/example/ajay/0.0.1/ajay-0.0.1-SNAPSHOT.jar"
                    def jarFile = "C:\\Users\\Ajay Maurya\\.jenkins\\workspace\\JavaAPP1\\WebApp\\target\\ajay-0.0.1-SNAPSHOT.jar"

                    // Execute curl command using bat for Windows
                    bat """
                        curl -v -u admin:admin --upload-file "${jarFile}" ${nexusUrl}
                    """
                }
            }
        }
    }
}
