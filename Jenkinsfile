// /*=============================== New Jenkinsfile ============================*/

// pipeline {
//     agent { 
//         node {label 'nodejs'}
//      }
     
//     environment {
//         CI = 'true'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 // sh '''
//                 //     docker build . -t react-openshift
//                 // '''
//                 sh 'npm install'
//                 sh 'npm run build'
//             }
//         }

//         stage('Test') {
//             steps {
//                 sh "chmod +x -R ${env.WORKSPACE}"
//                 sh './jenkins/scripts/test.sh'
//             }
//         }
      
//         stage('Deliver') {
//             steps {
//                 sh "chmod +x -R ${env.WORKSPACE}"
//                 sh './jenkins/scripts/deliver.sh'
//                 input message: 'Finished using the web site? (Click "Proceed" to continue)'
//                 sh "chmod +x -R ${env.WORKSPACE}"
//                 sh './jenkins/scripts/kill.sh'
//             }
//         }
//     }
// }







pipeline {

  agent {
    label 'nodejs'
  }

  stages {
    stage('Build') {
      steps {
        echo 'Building..'
        
        sh 'npm install'
        sh 'npm run build'
      }
    }
    stage('Create Container Image') {
      steps {
        echo 'Create Container Image..'
        
        script {

          
          openshift.withCluster() { 
              openshift.withProject("swatinegi406-dev") {
  
                    def buildConfigExists = openshift.selector("bc", "reactapplication").exists() 
    
                    if(!buildConfigExists){ 
                      openshift.newBuild("--name=reactapplication", "--docker-image=registry.access.redhat.com/ubi8/nodejs-16:1-37", "--binary") 
                     } 
    
                    openshift.selector("bc", "reactapplication").startBuild('--from-file= /opt/app-root/src/package.json', "--follow") } }

          }
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
        script {

          
          openshift.withCluster() { 
              openshift.withProject("swatinegi406-dev") { 
                             def deployment = openshift.selector("dc", "reactapplication") 

                            if(!deployment.exists()){ 
                              openshift.newApp('reactapplication', "--as-deployment-config").narrow('svc').expose() 
                            } 

                            timeout(5) { 
                              openshift.selector("dc", "reactapplication").related('pods').untilEach(1) { 
                                return (it.object().status.phase == "Running") 
      } 
    } 
  } 
}

        }
      }
    }
  }
}
