pipeline {
    agent any

    environment {
        // Define environment variable for Nexus credentials
        NEXUS_CREDENTIALS = credentials('nexus-admin-credentials')
    }

    stages {
        stage('Clone') {
            steps {
                git 'git@github.com:Ajay1672/Docker-Jenkins-Java-Application.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build project using Maven
                    bat 'mvn clean install'
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                script {
                    // Use credentials for Nexus repository
                    withCredentials([usernamePassword(credentialsId: 'nexus-admin-credentials', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
                        // Deploy to Nexus repository using Maven
                        bat """
                            mvn deploy:deploy-file \
                            -Dfile=target/ajay-0.0.1-SNAPSHOT.jar \
                            -DrepositoryId=nexus-releases \
                            -Durl=http://localhost:8081/repository/java-maven-app/ \
                            -DgroupId=com.example \
                            -DartifactId=ajay \
                            -Dversion=0.0.1-SNAPSHOT \
                            -Dpackaging=jar \
                            -Dusername=${env.NEXUS_USERNAME} \
                            -Dpassword=${env.NEXUS_PASSWORD}
                        """
                    }
                }
            }
        }
    }
}
