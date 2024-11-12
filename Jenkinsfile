pipeline {
    agent any

    environment {
        // Define Nexus repository URL (you can remove this if you want to use the one in pom.xml)
        NEXUS_REPO_URL = 'http://localhost:8081/repository/java-maven-app/'
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

        stage('Package') {
            steps {
                dir('WebApp') {
                    bat 'mvn package'
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-admin-credentials', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
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
    }
}
