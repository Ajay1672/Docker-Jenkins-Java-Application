pipeline {
    agent any

    environment {
        SLACK_CHANNEL = '#devops'  // Replace with the channel you want to post to
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

         stage('Upload to Nexus') {
            steps {
                script {
                    def artifactPath = 'WebApp/target/ajay-0.0.1-SNAPSHOT.jar'
                    def version = "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}"
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

    }

    post {
        always {
            script {
                // Define color map for Slack
                def COLOR_MAP = [
                    'SUCCESS': 'good',    // Green for success
                    'FAILURE': 'danger',  // Red for failure
                    'UNSTABLE': 'warning' // Yellow for unstable builds
                ]

                // Determine the build status
                def buildStatus = currentBuild.result ?: 'SUCCESS'  // Default to 'SUCCESS' if no result is set

                // Send the Slack message with the appropriate color
                slackSend(
                    channel: SLACK_CHANNEL,
                    color: COLOR_MAP[buildStatus], 
                    message: "Build #${env.BUILD_ID} ${buildStatus} - ${env.JOB_NAME} (${env.BUILD_URL})"
                )
            }
        }
    }
}
