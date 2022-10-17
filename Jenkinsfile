pipeline {
    agent any
       tools {
      maven 'maven3'
                 jdk 'JDK8'
    }
    stages {      
        stage('Build maven ') {
            steps { 
                    sh 'pwd'      
                    sh 'mvn  -e clean install package'
            }
        }
        
        stage('Copy Artifact') {
           steps { 
                   sh 'pwd'
		   sh 'cp -r target/*.jar docker'
           }
        }  
        stage('Build') {
            steps {
                sh './gradlew assemble'
            }
        }
        stage('Test') {
            steps {
                sh './gradlew test'
            }
        }
 
        stage('Build docker image') {
           steps {
               script {         
                 def customImage = docker.build('rameshkothamasu/samplecode-spring', "./docker")
                 docker.withRegistry('https://registry.hub.docker.com', '7171e3ed-650e-4ac4-8462-d46d239c7f91') {
                 customImage.push("${env.BUILD_NUMBER}")
                 }
                }
            } 
        }
    }
}
