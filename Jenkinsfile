pipeline {
    agent any
    
    stages {
        stage('Fix Git Permissions') {
            steps {
                script {
                    /
                    sh '''
                    git config --global --add safe.directory /var/jenkins_home/workspace/YannBotAI
                    git config --global --add safe.directory /var/jenkins_home/workspace/YannBotAI@libs
                    '''
                }
            }
        }
        
        stage('Extract Git Info') {
            steps {
                echo '🔍 Extracting Git information...'
                script {
                    env.COMMIT_SHA = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
                    env.SHORT_SHA = env.COMMIT_SHA.substring(0, 7)
                    env.IMAGE_TAG = "build-${env.BUILD_NUMBER}-${env.SHORT_SHA}"
                    
                    echo "IMAGE_TAG: ${env.IMAGE_TAG}"
                    echo "COMMIT_SHA: ${env.COMMIT_SHA}"
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    docker build -t yann177/yann-chatbot:${env.IMAGE_TAG} .
                    """
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh """
                        echo \"\${DOCKER_PASS}\" | docker login -u \"\${DOCKER_USER}\" --password-stdin
                        docker push yann177/yann-chatbot:${env.IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo "✅ Success!  ashhhh Image: yann177/yann-chatbot:${env.IMAGE_TAG}"
        }
        failure{
            echo " Le build a ndem fort fort ashhhh"
        }
    }
}