pipeline {
    agent any

    environment {
        // Define environment variables (like Nexus repository credentials)
        NEXUS_REPO_URL = 'http://localhost:8081/repository/java-maven-app/'
        NEXUS_USERNAME = credentials('admin')
        NEXUS_PASSWORD = credentials('admin')
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'a', url: 'git@github.com:Ajay1672/Docker-Jenkins-Java-Application.git'
            }
        }

        stage('Clean') {
            steps {
                dir('WebApp') {  
                    bat 'mvn clean'
                }
            }
        }

        stage('Packages') {
            steps {
                dir('WebApp') {  
                    bat 'mvn package'
                }
            }
        }

        stage('Maven Nexus Deploy') {
            steps {
                dir('WebApp') {  
                    bat """
                        mvn clean deploy -DrepositoryId=nexus-releases \
                            -Durl=${NEXUS_REPO_URL} \
                            -Dusername=${NEXUS_USERNAME} \
                            -Dpassword=${NEXUS_PASSWORD}
                    """
                }
            }
        }
    }
}
