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
//                 { 
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
//                 { 
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




/*----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------*/




// #!groovy

import java.text.SimpleDateFormat

node(){
    def dateFormat = new SimpleDateFormat("yyyyMMddHHmm")
    def dockerTag = dateFormat.format(new Date())
    def dockerName='marco-test'

    stage('get souce code') {
        try {
            echo "get source code"
            checkout scm
        }
        catch(err) {
            echo "get source code failed"
            throw err
        }
    }

    stage('npm run build') {
        try{
            docker.image('node:12-alpine').inside {
                sh 'node --version'
                sh 'npm --version'
                sh "npm --registry https://registry.npm.taobao.org install"
                sh 'npm install'
                sh 'npm run build'
            }
            }
        catch(err){
                echo "npm run build failed"
                throw err
            }
    }

    stage('deploy with nginx') {
        try {
            sh 'pwd'
            sh 'ls'
            sh 'cp -r build ./devops_build'

            sh "docker rm -f ${dockerName}"
            sh "docker build --no-cache=true -t ${dockerName}:${dockerTag} ./devops_build"

            sh "docker run -u root --name ${dockerName} -p 3000:80 -it -d ${dockerName}:${dockerTag}"

            // only retain last 3 images
            sh """docker rmi -f \$(docker images | grep ${dockerName} | sed -n  '4,\$p' | awk '{print \$3}') || true"""
        }
        catch(err){
                echo "deploy with Nginx failed"
                throw err
            }
    }
}




/*=============================== New Jenkinsfile ============================*/

// pipeline {
//     agent { 
//     node { label 'nodejs' }
//      }
     
//     environment {
//         CI = 'true'
//         JENKINS_CRUMB = 'curl user username:password "<jenkins-url>/crumbIssuer/api/xml?xpath=concat(//crumbRequestField, \":\",//crumb)"'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 sh 'npm install'
//             }
//         }
      
//         stage('Deliver') {
//             steps {
//                 sh "chmod +x -R ${env.WORKSPACE}"
//                 sh './jenkins/scripts/deliver.sh'
//                 // input message: 'Finished using the web site? (Click "Proceed" to continue)'
//                 // sh "chmod +x -R ${env.WORKSPACE}"
//                 // sh './jenkins/scripts/kill.sh'
//             }
//         }
//     }
// }



/*************************************************************************************/

// def projectName = currentBuild.projectName
// def version = env.BUILD_NUMBER
// def buildTag = env.BUILD_TAG
// def fileName = env.npmPack
// pipeline {
//     agent { 
//     node { label 'nodejs' }
//      }
     
//     environment {
//         CI = 'true'
//         JENKINS_CRUMB = 'curl user username:password "<jenkins-url>/crumbIssuer/api/xml?xpath=concat(//crumbRequestField, \":\",//crumb)"'
		
//     }
//     stages {
//         // stage("Checkout") {
//         //     steps {
//         //         load "environmentVariables.groovy"
//         //         echo "${env.DEV_SCM_REPOSITORY}"
//         //         echo "${env.DEV_SCM_BRANCH}"
//         //         git(url: "${env.DEV_SCM_REPOSITORY}", branch: "${env.DEV_SCM_BRANCH}", poll: true)
//         //     }
//         // }

//         stage("Build") {
//         steps {
//                 echo "Building.."
//                 //sh 'mvn org.codehaus.mojo:exec-maven-plugin:exec'
//                sh 'npm install'
//             }
// 		}
	
		
//         // stage("Quality Gate") {
//         //     steps {
//         //         timeout(time: 1, unit: 'HOURS') {
//         //             // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
//         //             // true = set pipeline to UNSTABLE, false = don't
//         //             // Requires SonarQube Scanner for Jenkins 2.7+
//         //             waitForQualityGate abortPipeline: true
//         //         }
//         //     }
//         // }

// //          stage('Test') {
// //             steps {
// //                 sh "chmod +x -R ${env.WORKSPACE}"
// //                 sh './jenkins/scripts/test.sh'
// //             }
// //         }

        
//         stage('Pack artefacts'){
//             steps {
//             script {
//                 def npmPack = sh(returnStdout:true, script:'npm pack').trim()
//                 env.npmPack = npmPack
//             	sh "echo ${npmPack}"
//             }   
//             }
//         }

        
//         stage('Archive/Upload Artefact to Nexus'){
 
//                 steps{
//                       nexusArtifactUploader(
// 						    nexusVersion: 'nexus3',
// 						    protocol: 'http',
// 						    nexusUrl: 'localhost:8081',
// 						    groupId: 'com.example',
// 						    version: version,
// 						    repository: 'DynamicsDeveloperReleases',
// 						    credentialsId: 'jenkins-nexus-authentication',
// 						    artifacts: [
// 						        [artifactId: projectName,
// 						         classifier: '',
// 						         file: fileName,
// 						         type: 'tgz']
// 						    			]
//  									)
//                                           }
//                                        }
//     								}

//     post {
//         always {
//           cleanWs() 
          
 
//         }
        
//         success{
            
//                 sh 'git commit "package.json" -m'
            

//         }

        
//         failure {
//              //mail to: 'someone@somewhere.com' , subject: "Status of pipeline: ${currentBuild.fullDisplayName}" , body: "${env.BUILD_URL} has result ${currentBuild.result}"
//         	echo "${currentBuild.projectName} has failed at ${env.BUILD_URL}"
        	
//         }
       
//     }
        
//     }



