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







// pipeline {

//   agent {
//     label 'nodejs'
//   }

//   stages {
//     stage('Build') {
//       steps {
//         echo 'Building..'
        
//         sh 'npm install'
//         // sh 'npm install -g serve'
//         // sh 'serve -s build -l 8080'
//         sh 'npm run build'
//       }
//     }
//     stage('Create Container Image') {
//       steps {
//         echo 'Create Container Image..'
        
//         script {

          
//           openshift.withCluster() { 
//               openshift.withProject("swatinegi406-dev") {
  
//                     def buildConfigExists = openshift.selector("bc", "reactapplication").exists() 
    
//                     if(!buildConfigExists){ 
//                       openshift.newBuild("--name=reactapplication", "--docker-image=registry.access.redhat.com/ubi8/nodejs-16:1-37.1652296488", "--binary") 
//                      } 
    
//                     openshift.selector("bc", "reactapplication").startBuild('--from-file=./package.json', '--follow') 
//                 } 
//             }

//           }
//       }
//     }
//     stage('Deploy') {
//       steps {
//         echo 'Deploying....'
//         script {

          
//           openshift.withCluster() { 
//               openshift.withProject("swatinegi406-dev") { 
//                             def deployment = openshift.selector("dc", "reactapplication") 

//                             if(!deployment.exists()){ 
//                               openshift.newApp('reactapplication', "--as-deployment-config").narrow('svc').expose() 
//                             } 

//                             timeout(5) { 
//                               openshift.selector("dc", "reactapplication").related('pods').untilEach(1) { 
//                                 return (it.object().status.phase == "Running") 
//       } 
//     } 
//   } 
// }

//         }
//       }
//     }
//   }
// }




def templatePath = 'jenkins-react'
def templateName = 'jenkins-react' 
pipeline {
  agent {
    node {
      label 'nodejs' 
    }
  }
  options {
    timeout(time: 20, unit: 'MINUTES') 
  }
  stages {
    stage('preamble') {
        steps {
            script {
                openshift.withCluster() {
                    openshift.withProject("swatinegi1482-dev") {
                        echo "Using project: ${openshift.project()}"
                    }
                }
            }
        }
    }
    stage('cleanup') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject("swatinegi1482-dev") {
                  openshift.selector("all", [ template : templateName ]).delete() 
                  if (openshift.selector("secrets", templateName).exists()) { 
                    openshift.selector("secrets", templateName).delete()
                  }
                }
            }
        }
      }
    }
    stage('create') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject("swatinegi1482-dev") {
                  openshift.newApp(templatePath) 
                }
            }
        }
      }
    }
    stage('build') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject("swatinegi1482-dev") {
                  def builds = openshift.selector("bc", templateName).related('builds')
			timeout(5){
                    		builds.untilEach(1) {
                      		return (it.object().status.phase == "Complete")
		    	}
                  }
                }
            }
        }
      }
    }
    stage('deploy') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject("swatinegi1482-dev") {
                  def rm = openshift.selector("dc", templateName).rollout().latest()
                timeout(5){ 
                    openshift.selector("dc", templateName).related('pods').untilEach(1) {
                      return (it.object().status.phase == "Running")
                    }
                  }
                }
            }
        }
      }
    }
    stage('tag') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject() {
                  openshift.tag("${templateName}:latest", "${templateName}-staging:latest") 
                }
            }
        }
      }
    }
  }
}
