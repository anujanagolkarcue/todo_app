pipeline {
    agent any
    stages {
        stage('Build') {
            when {
                branch 'master'
            }
            steps {
                sh 'echo "My first pipeline"'
                sh '''
                   echo ${BRANCH_NAME}
                '''
            }
        }
    }
}
