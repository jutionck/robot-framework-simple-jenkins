pipeline {
    agent any
    stages {
        stage("Clone Source") {
            steps {
                echo 'Clone Source'
                git branch: 'main', url: 'git@github.com:jutionck/robot-framework-simple-jenkins.git'
            }
        }

        stage("Robot Check") {
            steps {
                echo 'Robot Check'
                sh '/Library/Frameworks/Python.framework/Versions/3.11/bin/robot --version'
            }
        }

        stage("Test") {
            steps {
                echo 'Test'
                sh '/Library/Frameworks/Python.framework/Versions/3.11/bin/robot -d Results main.robot'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
            slackSend(channel: '#training', message: "Build deployed successfully - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)")
        }
        failure {
            echo 'This will run only if failed'
        }
    }
}
