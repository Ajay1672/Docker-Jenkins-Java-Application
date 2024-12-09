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
                bat 'cd WebApp && mvn clean'
            }
        }

        stage('Package') {
            steps {
                bat 'cd WebApp && mvn package'
            }
        }

        // stage('Test Nexus URL') {
        //     steps {
        //         bat 'curl -v http://localhost:8081/#admin/repository/repositories:vprofile-release'
        //     }
        // }

        // Uncomment and configure the following if you want to perform SonarQube analysis
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('sonumonu') {
        //             bat 'cd WebApp && mvn sonar:sonar -Dsonar.projectKey=Docker-Jenkins-Java-Application \
        //                 -Dsonar.host.url=http://localhost:9000'
        //         }
        //     }
        // }

        // Uncomment and configure the following to enforce a Quality Gate
        // stage('Quality Gate') {
        //     steps {
        //         script {
        //             def qualityGate = waitForQualityGate()
        //             if (qualityGate.status != 'OK') {
        //                 error "Quality Gate 'bugs' failed: ${qualityGate.status}"
        //             } else {
        //                 echo "Quality Gate 'bugs' passed!"
        //             }
        //         }
        //     }
        // }

        stage('Upload to Nexus') {
            steps {
                script {
                    def artifactPath = 'WebApp/target/ajay-0.0.1-SNAPSHOT.jar'
                    def repositoryUrl = 'http://localhost:8081/repository/vprofile-release/com/example/ajay/0.0.1/ajay-0.0.1-SNAPSHOT.jar'

                    if (fileExists(artifactPath)) {
                        echo "Uploading artifact to Nexus..."
                        bat """
                            curl -v -u admin:admin --upload-file ${artifactPath} ${repositoryUrl}
                        """
                    } else {
                        error "The artifact ${artifactPath} does not exist!"
                    }
                }
            }
        }
    } // Closing the 'stages' block
}
