pipeline {
    agent any
    stages {
        stage('Build') {
            when {
                anyOf {
                     L:{ branch 'develop' }
                     L:{ branch "/(?i)^.*-backend" }
                }
            }
            steps {
                sh 'echo "In BUILD"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
        stage('Test') {
            when {
                branch pattern: "/(?i)^.*-backend", comparator: "REGEXP"
            }
            steps {
                sh 'echo "In Test"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
        stage('Test2') {
            when {
                branch "/(?i)^.*-backend"
            }
            steps {
                sh 'echo "In Test"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
    }
}
