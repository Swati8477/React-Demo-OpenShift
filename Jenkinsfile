/*=============================== New Jenkinsfile ============================*/

pipeline {
    agent { 
        node {label 'nodejs'}
     }
     
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                // sh '''
                //     docker build . -t react-openshift
                // '''
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh "chmod +x -R ${env.WORKSPACE}"
                sh './jenkins/scripts/test.sh'
            }
        }
      
        stage('Deliver') {
            steps {
                sh "chmod +x -R ${env.WORKSPACE}"
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh "chmod +x -R ${env.WORKSPACE}"
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}

