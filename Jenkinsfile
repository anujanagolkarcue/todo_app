pipeline {
    agent any
    stages {
        stage('Build') {
            when {
                anyOf {
                    branch 'develop'
                    or { branch pattern: "/(?i)^.*-backend", comparator: "REGEXP" }
                }
            }
            steps {
                sh 'echo "In BUILD"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
        stage('Test') {
            when {
                anyOf {
                    branch pattern: "/(?i)^.*-backend", comparator: "REGEXP"
                }
            }
            steps {
                sh 'echo "In Test"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
        stage('Test2') {
            when {
                anyOf {
                    branch pattern: "/(?i)^.*-backend", comparator: "REGEXP"
                }
            }
            steps {
                sh 'echo "In Test"'
                sh 'echo ${BRANCH_NAME}'
            }
        }
    }
}
