/*=============================== New Jenkinsfile ============================*/

// pipeline {
//     agent { 
//         node {label 'nodejs'}
//     //   dockerfile true
//     // docker { 
//     //     image 'node:16.13.1-alpine' 
//     //     label 'docker'
//     //     args '-p 3000:3000'
//     //     }
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

/*-----------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------*/


//   // path of the template to use
//         def templatePath = 'https://github.com/Swati8477/React-Demo-OpenShift.git'
//         // name of the template that will be created
//         def templateName = 'react-application'
//         // NOTE, the "pipeline" directive/closure from the declarative pipeline syntax needs to include, or be nested outside,
//         // and "openshift" directive/closure from the OpenShift Client Plugin for Jenkins.  Otherwise, the declarative pipeline engine
//         // will not be fully engaged.
//         pipeline {
//             agent {
//               node {
//                 // spin up a node.js slave pod to run this build on
//                 label 'nodejs'
//               }
//             }
//             options {
//                 // set a timeout of 20 minutes for this pipeline
//                 timeout(time: 20, unit: 'MINUTES')
//             }
//             stages {
//                 stage('preamble') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject(swatinegi1482-dev) {
//                                     echo "Using project: ${openshift.project()}"
//                                 }
//                             }
//                         }
//                     }
//                 }
//                 stage('cleanup') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject(swatinegi1482-dev) {
//                                     // delete everything with this template label
//                                     openshift.selector("all", [ template : templateName ]).delete()
//                                     // delete any secrets with this template label
//                                     if (openshift.selector("secrets", templateName).exists()) {
//                                         openshift.selector("secrets", templateName).delete()
//                                     }
//                                 }
//                             }
//                         } // script
//                     } // steps
//                 } // stage
//                 stage('create') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject(swatinegi1482-dev) {
//                                     // create a new application from the templatePath
//                                     openshift.newApp(templatePath)
//                                 }
//                             }
//                         } // script
//                     } // steps
//                 } // stage
//                 stage('build') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject(swatinegi1482-dev) {
//                                     def builds = openshift.selector("bc", templateName).related('builds')
//                                     builds.untilEach(1) {
//                                         return (it.object().status.phase == "Complete")
//                                     }
//                                 }
//                             }
//                         } // script
//                     } // steps
//                 } // stage
//                 stage('deploy') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject(swatinegi1482-dev) {
//                                     def rm = openshift.selector("dc", templateName).rollout()
//                                     openshift.selector("dc", templateName).related('pods').untilEach(1) {
//                                         return (it.object().status.phase == "Running")
//                                     }
//                                 }
//                             }
//                         } // script
//                     } // steps
//                 } // stage
//                 stage('tag') {
//                     steps {
//                         script {
//                             openshift.withCluster() {
//                                 openshift.withProject() {
//                                     // if everything else succeeded, tag the ${templateName}:latest image as ${templateName}-staging:latest
//                                     // a pipeline build config for the staging environment can watch for the ${templateName}-staging:latest
//                                     // image to change and then deploy it to the staging environment
//                                     openshift.tag("${templateName}:latest", "${templateName}-staging:latest")
//                                 }
//                             }
//                         } // script
//                     } // steps
//                 } // stage
//             } // stages
//         } // pipeline




/*========================================================================================
========================================================================================*/



pipeline {
  environment {
    registry = "swati8477/react-demo"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
     agent any
     //{
//   tools {node "nodejs" }
//   node {label 'nodejs'}
        
//     }
  stages {
//     stage('Cloning Git') {
//       steps {
//         git 'https://github.com/Swati8477/React-Demo-OpenShift.git'
//         refs 'main'
//       }
//    }
    stage('Build') {
       steps {
         sh 'npm install'
       }
    }
    stage('Test') {
      steps {
        sh 'npm test'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    // stage('Remove Unused docker image') {
    //   steps{
    //     sh "docker rmi $registry:$BUILD_NUMBER"
    //   }
    // }
  }
}
