pipeline {
    agent any
    environment {
        GIT_URL = 'git@github.com:jutionck/robot-framework-simple-jenkins.git'
        BRANCH = 'main'
        ROBOT = '/Library/Frameworks/Python.framework/Versions/3.11/bin/robot'
        CHANNEL = '#training'
        IMAGE = 'my-robot-test'
    }
    stages {
        stage("Clone") {
            steps {
                echo 'Clone'
                git branch: "${BRANCH}", url: "${GIT_URL}"
            }
        }

        stage("Build") {
            steps {
                echo 'Build'
                sh "docker build -t ${IMAGE} ."
            }
        }
        
        stage("Run") {
            steps {
                echo 'Run Test'
                sh "docker run --rm ${IMAGE}"
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
            slackSend(channel: "${CHANNEL}", message: "Build deployed successfully - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)")
            step(
                    [
                            $class              : 'RobotPublisher',
                            outputPath          : 'reports',
                            outputFileName      : "output.xml",
                            reportFileName      : 'report.html',
                            logFileName         : 'log.html',
                            disableArchiveOutput: true,
                            passThreshold       : 95.0,
                            unstableThreshold   : 90.0,
                            otherFiles          : "**/*.png,**/*.jpg",
                    ]
            )
        }
        failure {
            echo 'This will run only if failed'
            slackSend(channel: "${CHANNEL}", message: "Build deployed failed - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)")
        }
    }
}
