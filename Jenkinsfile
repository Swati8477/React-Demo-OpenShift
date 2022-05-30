/*=============================== New Jenkinsfile ============================*/

// pipeline {
//     agent { 
//     //   dockerfile true
//     docker { image 'node:16.13.1-alpine' }
// //       docker {
// //             image 'node:lts-buster-slim'
// //             args '-p 3000:3000'
// //         }
//      }
     
//     environment {
//         CI = 'true'
//     }
//     stages {
//         stage('Build') {
//             steps {
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


   try {
             timeout(time: 20, unit: 'MINUTES') {
                node('nodejs') {
                    stage('build') {
                      openshift.withCluster() {
                         openshift.withProject() {
                            def bld = openshift.startBuild('react-demo-openshift')
                            bld.untilEach {
                              return it.object().status.phase == "Running"
                            }
                            bld.logs('-f')
                         }
                      }
                    }
                    stage('deploy') {
                      openshift.withCluster() {
                        openshift.withProject() {
                          def dc = openshift.selector('dc', 'react-demo-openshift')
                          dc.rollout().latest()
                        }
                      }
                    }
                  }
             }
          } catch (err) {
             echo "in catch block"
             echo "Caught: ${err}"
             currentBuild.result = 'FAILURE'
             throw err
          }
