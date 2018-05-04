pipeline {
    agent { label "master" }
    tools {
        maven 'M3'
    }
    stages {
        stage("build artifact") {
			steps{
				checkout scm
				sh "ls -l"
				sh "mvn clean package"
			}
        } 
    }

}
    
    
    
