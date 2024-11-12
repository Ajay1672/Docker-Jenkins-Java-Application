pipeline {
    agent any

    environment {
        NEXUS_CREDENTIALS = credentials('nexus-admin-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Change to the directory where pom.xml is located
                    dir('WebApp') {
                        bat 'mvn clean install'
                    }
                }
            }
        }

             stage('Package') {
            steps {
                script {
                    // Change to the directory where pom.xml is located
                    dir('WebApp') {
                        bat 'mvn package'
                    }
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-admin-credentials', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
                        bat """
    mvn deploy:deploy-file \
    -Dfile=C:\\Users\\Ajay Maurya\\.jenkins\\workspace\\MvnNexus\\target\\ajay-0.0.1-SNAPSHOT.jar \
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
