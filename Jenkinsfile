pipeline {
    agent any
    stages {
        stage('Build') {
            when (BRANCH_NAME == 'master') {
                steps {
                    sh 'echo "IN 2nd When"'
                    sh '''
                    printenv | grep branch
                        echo "By the way, I can do more stuff in here"
                        ls -lah
                    '''
                    sh '''
                    echo ${BRANCH_NAME}
                    echo 'Next'
                    printenv | grep BRANCH
                    '''
                }
            }
            when (BRANCH_NAME != 'master') {
                steps {
                    sh 'echo "IN 2nd When"'
                    sh '''
                    printenv | grep branch
                        echo "By the way, I can do more stuff in here"
                        ls -lah
                    '''
                    sh '''
                    echo ${BRANCH_NAME}
                    echo 'Next'
                    printenv | grep BRANCH
                    '''
                }
            }
        }
    }
}
