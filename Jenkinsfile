/*=============================== New Jenkinsfile ============================*/

pipeline {
    agent { 
      node { 
        label 'nodejs' 
      }
//       docker {
//             image 'node:lts-buster-slim'
//             args '-p 3000:3000'
//         }
     }
     
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

//         stage('Test') {
//             steps {
//                 sh "chmod +x -R ${env.WORKSPACE}"
//                 sh './jenkins/scripts/test.sh'
//             }
//         }
      
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


