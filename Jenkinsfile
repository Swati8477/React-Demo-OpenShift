/*=================================Jenkin file for React JS ==========================================*/

def templatePath = 'https://github.com/Swati8477/React-Demo-OpenShift.git'
def templateName = 'react-openshift-app' 
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
                    openshift.withProject() {
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
                openshift.withProject() {
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
                openshift.withProject() {
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
                openshift.withProject() {
                  def builds = openshift.selector("bc", templateName).related('builds')
                  timeout(5) { 
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
                openshift.withProject() {
                  def rm = openshift.selector("dc", templateName).rollout().latest()
                  timeout(5) { 
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




/*================================= Jenkin file for SpringBoot ========================================*/


// #! /usr/bin/env groovy

// pipeline {

//   agent {
//     label 'npm'
//   }

//   stages {
//     stage('Build') {
//       steps {
//         echo 'Building..'
        
//         sh 'mvn clean package'
//       }
//     }
//     stage('Create Container Image') {
//       steps {
//         echo 'Create Container Image..'
        
//         script {

          
//           openshift.withCluster() { 
//               openshift.withProject("swatinegi1482-dev") {
  
//                     def buildConfigExists = openshift.selector("bc", "codelikethewind").exists() 
    
//                     if(!buildConfigExists){ 
//                       openshift.newBuild("--name=codelikethewind", "--docker-image=registry.redhat.io/jboss-eap-7/eap74-openjdk8-openshift-rhel7", "--binary") 
//                      } 
    
//                     openshift.selector("bc", "codelikethewind").startBuild("--from-file=target/simple-servlet-0.0.1-SNAPSHOT.war", "--follow") } }

//           }
//       }
//     }
//     stage('Deploy') {
//       steps {
//         echo 'Deploying....'
//         script {

          
//           openshift.withCluster() { 
//               openshift.withProject("swatinegi1482-dev") { 
//                              def deployment = openshift.selector("dc", "codelikethewind") 

//                             if(!deployment.exists()){ 
//                               openshift.newApp('codelikethewind', "--as-deployment-config").narrow('svc').expose() 
//                             } 

//                             timeout(5) { 
//                               openshift.selector("dc", "codelikethewind").related('pods').untilEach(1) { 
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