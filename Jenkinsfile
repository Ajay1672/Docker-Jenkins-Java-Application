pipeline {
    agent any

    environment {
        NEXUS_CREDENTIALS = credentials('nexus-admin-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // This ensures the correct repository is checked out
                script {
                    // Debugging step to verify the directory and list files
                    bat 'dir'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Ensure we are in the correct directory where pom.xml is located
                    bat 'cd C:\\Users\\Ajay Maurya\\.jenkins\\workspace\\MavenNexusDeployment && mvn clean install'
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-admin-credentials', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
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
