pipeline {
    agent any
    
    environment {
        // These will be set by Jenkins when webhook triggers
        COMMITTER = "${env.GIT_COMMITTER ?: 'manual'}"
        COMMIT_SHA = "${env.GIT_COMMIT ?: 'unknown'}"
        BRANCH_NAME = "${env.GIT_BRANCH ?: 'unknown'}"
        SHORT_SHA = "${env.GIT_COMMIT ? env.GIT_COMMIT.substring(0, 7) : 'unknown'}"
    }
    
    stages {
        stage('Extract GitHub Info') {
            steps {
                echo '🔍 Extracting GitHub webhook data...'
                script {
                    // Debug what info we have
                    echo "GIT_BRANCH: ${env.GIT_BRANCH}"
                    echo "GIT_COMMIT: ${env.GIT_COMMIT}" 
                    echo "GIT_URL: ${env.GIT_URL}"
                    
                    // Try to extract PR info (may not work yet)
                    echo "CHANGE_ID: ${env.CHANGE_ID ?: 'NOT SET'}"
                    echo "CHANGE_AUTHOR: ${env.CHANGE_AUTHOR ?: 'NOT SET'}"
                    
                    // For now, create a simple tag
                    IMAGE_TAG = "build-${env.BUILD_NUMBER}-${SHORT_SHA}"
                    echo "IMAGE_TAG: ${IMAGE_TAG}"
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                script {
                    // Build with dynamic tag
                    sh """
                    docker build -t yann177/yann-chatbot:${IMAGE_TAG} .
                    """
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                echo '📦 Pushing to DockerHub...'
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh """
                        echo \"\${DOCKER_PASS}\" | docker login -u \"\${DOCKER_USER}\" --password-stdin
                        docker push yann177/yann-chatbot:${IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo "✅ Success! Image: yann177/yann-chatbot:${IMAGE_TAG}"
            // We'll add Slack here later
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}