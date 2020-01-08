pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "My first pipeline"'
                sh '''
                   printenv | grep branch
                    echo "By the way, I can do more stuff in here"
                    ls -lah
                '''
                sh '''
                   echo ${BRANCH_NAME}
                   echo 'Next'
                   echo ${env.BRANCH_NAME}
                   printenv | grep BRANCH
                '''
            }
        }
    }
}
