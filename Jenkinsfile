pipeline {
    agent any
    
    environment {
        DOCKERHUB_URL = "https://hub.docker.com/r/yann177/yann-chatbot/tags"
        GITHUB_REPO_URL = "https://github.com/nnay29/YannBotAI"
    }
    
    stages {
        stage('Extract Git Info') {
            steps {
                echo '🔍 Extracting Git information...'
                script {
                    try {
                        env.COMMIT_SHA = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
                    } catch (Exception e) {
                        env.COMMIT_SHA = 'manual-build'
                    }
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
                    sh "docker build -t yann177/yann-chatbot:${env.IMAGE_TAG} ."
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
        always {
            script {
                // Slack notification using your credential ID
                withCredentials([string(credentialsId: 'slack-bot-token', variable: 'SLACK_WEBHOOK_URL')]) {
                    slackSend(
                        channel: '#jenkins-ci-builds',
                        color: currentBuild.currentResult == 'SUCCESS' ? 'good' : 'danger',
                        message: """
                        🚀 *ChatBot Build ${currentBuild.currentResult}* 
                        📦 *Image:* yann177/yann-chatbot:${env.IMAGE_TAG}
                        🔗 *DockerHub:* ${env.DOCKERHUB_URL}
                        📎 *GitHub:* ${env.GITHUB_REPO_URL}
                        🔢 *Build:* #${env.BUILD_NUMBER}
                        ⏱️ *Duration:* ${currentBuild.durationString}
                        """
                    )
                }
            }
        }
        
        success {
            echo "✅ Success! Image: yann177/yann-chatbot:${env.IMAGE_TAG}"
        }
        
        failure {
            echo "❌ Build failed! Check logs for details."
        }
    }
}