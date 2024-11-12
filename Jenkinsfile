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
------------------------------------------------------------------------------------------------------------------------------


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
