pipeline {
    agent any
    stages {
        stage('Build') {
            when {
                anyOf {
                    branch 'master'
                    branch pattern: "/(?i)^.*-backend", comparator: "REGEXP"
                }
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
