pipeline {
    agent any

  environment {
    NEXUS_VERSION = "nexus3"
    NEXUS_PROTOCOL = "http"
    NEXUS_REPOSITORY = "vprofile-release"
    NEXUS_CREDENTIAL_ID = "nex"
    ARTVERSION = "${env.BUILD_ID}"
}

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

        stage('Test Nexus URL') {
    steps {
        script {
            sh 'curl -v http://localhost:8081/#admin/repository/repositories:vprofile-release'
        }
    }
}


        stage('Upload to Nexus') {
            steps {
                script {
                    // Set the correct artifact path
                    def artifactPath = 'WebApp/target/ajay-0.0.1-SNAPSHOT.jar'
                    
                    // Check if the correct artifact file exists
                    if (fileExists(artifactPath)) {
                        // Use the Nexus Artifact Uploader plugin to upload the artifact
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: 'http://localhost:8081',
                            groupId: 'com.example',
                            version: '0.0.1-SNAPSHOT',
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: 'ajay',
                                 file: artifactPath,   // Correct file path
                                 type: 'jar']
                            ]
                        )
                    } else {
                        error "The artifact ${artifactPath} does not exist!"
                    }
                }
            }
        }
    }
}
