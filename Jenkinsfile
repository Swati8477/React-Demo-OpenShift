// /*=================================Jenkin file for React JS ==========================================*/

// def templatePath = 'https://github.com/Swati8477/React-Demo-OpenShift.git'
// def templateName = 'react-openshift-app' 
// pipeline {
//   agent {
//     node {
//       label 'nodejs' 
//     }
//   }
//   options {
//     timeout(time: 20, unit: 'MINUTES') 
//   }
//   stages {
//     stage('preamble') {
//         steps {
//             script {
//                 openshift.withCluster() {
//                     openshift.withProject() {
//                         echo "Using project: ${openshift.project()}"
//                     }
//                 }
//             }
//         }
//     }
//     stage('cleanup') {
//       steps {
//         script {
//             openshift.withCluster() {
//                 openshift.withProject() {
//                   openshift.selector("all", [ template : templateName ]).delete() 
//                   if (openshift.selector("secrets", templateName).exists()) { 
//                     openshift.selector("secrets", templateName).delete()
//                   }
//                 }
//             }
//         }
//       }
//     }
//     stage('create') {
//       steps {
//         script {
//             openshift.withCluster() {
//                 openshift.withProject() {
//                   openshift.newApp(templatePath) 
//                 }
//             }
//         }
//       }
//     }
//     stage('build') {
//       steps {
//         script {
//             openshift.withCluster() {
//                 openshift.withProject() {
//                   def builds = openshift.selector("bc", templateName).related('builds')
//                   timeout(5) { 
//                     builds.untilEach(1) {
//                       return (it.object().status.phase == "Complete")
//                     }
//                   }
//                 }
//             }
//         }
//       }
//     }
//     stage('deploy') {
//       steps {
//         script {
//             openshift.withCluster() {
//                 openshift.withProject() {
//                   def rm = openshift.selector("dc", templateName).rollout().latest()
//                   timeout(5) { 
//                     openshift.selector("dc", templateName).related('pods').untilEach(1) {
//                       return (it.object().status.phase == "Running")
//                     }
//                   }
//                 }
//             }
//         }
//       }
//     }
//     stage('tag') {
//       steps {
//         script {
//             openshift.withCluster() {
//                 openshift.withProject() {
//                   openshift.tag("${templateName}:latest", "${templateName}-staging:latest") 
//                 }
//             }
//         }
//       }
//     }
//   }
// }






/*=============================== New Jenkinsfile ============================*/


// pipeline {
//     agent {
//         docker {
//             image 'node:16-alpine3.14'
//             args '-p 3000:3000'
//         }
//     }
//     environment {
//         CI = 'true'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 sh 'npm install'
//             }
//         }
//         }
//         stage('Deliver') {
//             steps {
//                 sh './jenkins/scripts/deliver.sh'
//                 input message: 'Finished using the web site? (Click "Proceed" to continue)'
//                 sh './jenkins/scripts/kill.sh'
//             }
//         }
//     }
// }




/*========================= ANother Jnekinsfile ==============================*/


pipeline {
    options {
        // set a timeout of 60 minutes for this pipeline
        timeout(time: 60, unit: 'MINUTES')
    }

    environment {
        APP_NAME = "React-Demo-Openshift"
        DEV_PROJECT = "react-demo"
        APP_GIT_URL = "https://github.com/Swati8477/React-Demo-OpenShift.git"
    }
    
    agent {
      node {
        label 'nodejs'
      }
    }

    stages {
        stage('Deploy to DEV environment') {
            steps {
                echo '###### Deploy to DEV environment ######'
                script {
                    openshift.withCluster() {
                        openshift.withProject("$DEV_PROJECT") {
                            echo "Using project: ${openshift.project()}"
                            // If DeploymentConfig already exists, rollout to update the application
                            if (openshift.selector("dc", APP_NAME).exists()) {
                                echo "DeploymentConfig " + APP_NAME + " exists, rollout to update app ..."
                                // Rollout (it corresponds to oc rollout <deploymentconfig>)
                                def dc = openshift.selector("dc", "${APP_NAME}")
                                dc.rollout().latest()
                                // If a Route does not exist, expose the Service and create the Route
                                if (!openshift.selector("route", APP_NAME).exists()) {
                                    echo "Route " + APP_NAME + " does not exist, exposing service ..." 
                                    def service = openshift.selector("service", APP_NAME)
                                    service.expose()
                                }
                            } 
                            // If DeploymentConfig does not exist, deploy a new application using an OpenShift Template
                            else{
                                echo "DeploymentConfig " + APP_NAME + " does not exist, creating app ..."
                                openshift.newApp('deployment/openshift/windfire-restaurants-ui-template.yaml')
                            }
                            def route = openshift.selector("route", APP_NAME)
                            echo "Test application with "
                            def result = route.describe()   
                        }
                    }
                }
            }
        }
    }
}