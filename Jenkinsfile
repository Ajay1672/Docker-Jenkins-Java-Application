// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }

//         stage('Build') {
//             steps {
//                 script {
//                     // Change to the directory where pom.xml is located
//                     dir('WebApp') {
//                         bat 'mvn clean install'
//                     }
//                 }
//             }
//         }

//              stage('Package') {
//             steps {
//                 script {
//                     // Change to the directory where pom.xml is located
//                     dir('WebApp') {
//                         bat 'mvn package'
//                     }
//                 }
//             }
//         }

// //         stage('Deploy to Nexus') {
// //             steps {
// //                 script {
// //                     withCredentials([usernamePassword(credentialsId: 'nexus-admin-credentials', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
// //                         bat """
// //     mvn deploy:deploy-file \
// //     -Dfile=C:\\Users\\Ajay Maurya\\.jenkins\\workspace\\MvnNexus\\target\\ajay-0.0.1-SNAPSHOT.jar \
// //     -DrepositoryId=nexus-releases \
// //     -Durl=http://localhost:8081/repository/java-maven-app/ \
// //     -DgroupId=com.example \
// //     -DartifactId=ajay \
// //     -Dversion=0.0.1-SNAPSHOT \
// //     -Dpackaging=jar \
// //     -Dusername=${env.NEXUS_USERNAME} \
// //     -Dpassword=${env.NEXUS_PASSWORD}
// // """

// //                     }
// //                 }
// //             }
// //         }
//     }
// s
// ------------------------------------------------------------------------------------------------------------------------------

pipeline {
    agent any

    environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "http://localhost:8081/"
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

        stage('Upload to Nexus') {
            steps {
                script {
                    // Use the Nexus Artifact Uploader plugin to upload the artifact
                    nexusArtifactUploader(
                        nexusVersion: NEXUS_VERSION,
                        protocol: NEXUS_PROTOCOL,
                        nexusUrl: NEXUS_URL,
                        groupId: 'com.example',
                        version: '0.0.1-SNAPSHOT',
                        repository: NEXUS_REPOSITORY,
                        credentialsId: NEXUS_CREDENTIAL_ID,
                        artifacts: [
                            [artifactId: 'ajay',
                             file: 'target/ajay-0.0.1-SNAPSHOT.jar',
                             type: 'jar']
                        ]
                    )
                }
            }
        }
    }
}
