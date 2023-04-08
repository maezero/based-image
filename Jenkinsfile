pipeline {

    agent any
    options {
        buildDiscarder logRotator( 
                    daysToKeepStr: '15', 
                    numToKeepStr: '10'
            )
    }

    environment {
        APP_NAME = "based-image"
        APP_VERSION = "1.0.0"
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace for ${APP_NAME}"
                """
            }
        }

        stage('Code Checkout') {
                steps {
                        checkout([
                            $class: 'GitSCM', 
                            branches: [[name: '*/main']], 
                            userRemoteConfigs: [[url: 'https://github.com/maezero/based-image.git']]
                        ])
                }
        }

        stage('Run Docker Build') {
            steps {
                sh "docker build -t zerozang/${APP_NAME}:${APP_VERSION}-${BUILD_NUMBER} ."
            }
        }

        stage('Push Based-Image to Docker Hub') {
                
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker logout"
                    sh "docker login -u $USERNAME -p $PASSWORD"
                    sh "docker push zerozang/${APP_NAME}:${APP_VERSION}-${BUILD_NUMBER}"  
                }
            }         
        }

    }   
}
