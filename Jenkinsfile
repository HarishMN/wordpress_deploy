pipeline {
    agent any

    stages ("deploy"){
        steps {
            sh './Scripts/deploy.sh ${SERVER}'
        }
    }
}