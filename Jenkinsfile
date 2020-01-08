pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "My first pipeline"'
                sh '''
                    echo "By the way, I can do more stuff in here"
                    ls -lah
                '''
                sh '''
                   echo "Branch Name ===> ${env.BRANCH_NAME}"
                '''
            }
        }
    }
}
