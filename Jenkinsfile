pipeline {
    agent any
    stages{
        stage("deploy"){
            steps {
                sh "chmod +x -R ${env.WORKSPACE}"
                sh './Scripts/deploy.sh ${SERVER}'
            }
        }
    }
}