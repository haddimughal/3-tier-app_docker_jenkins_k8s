pipeline{

    agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_cred')
	}

	stages {
	    
	    stage('gitclone') {

			steps {
				git 'https://gitlab.mynisum.com/hdaoud/assginment-1.git'
                echo 'Repository successfully cloned from GitLab'
			}
		}

		stage('Build-Frontend') {

			steps {
				sh 'docker build -t hammaddaoud/nisum_assignment-1-frontend:latest /var/lib/jenkins/workspace/hammad/3-tier-pipeline/frontend/'
                echo 'Docker image created for frontend app'
			}
		}

		stage('Build-Backend') {

			steps {
				sh 'docker build -t hammaddaoud/nisum_assignment-1-backend:latest /var/lib/jenkins/workspace/hammad/3-tier-pipeline/backend/'
                echo 'Docker image created for backend app'
			}
		}

		stage('Build-Gateway') {

			steps {
				sh 'docker build -t hammaddaoud/nisum_assignment-1-gateway:latest /var/lib/jenkins/workspace/hammad/3-tier-pipeline/gateway/'
                echo 'Docker image created for gateway'
			}
		}        

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                echo 'Login successful'
            }
		}

		stage('Push') {

			steps {
				sh 'docker push hammaddaoud/nisum_assignment-1-frontend:latest'
                sh 'docker push hammaddaoud/nisum_assignment-1-backend:latest'
                sh 'docker push hammaddaoud/nisum_assignment-1-gateway:latest'

			}
		}
		stage('K8S-Deployment') {

			steps {
                //kubernetesDeploy(configs: "kubemanifests.yaml", kubeconfigId: "kubeconfig")
                //sh 'bash script.sh'
                withCredentials([kubeconfigFile(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) { 
                    
                    sh 'kubectl apply -f /var/lib/jenkins/workspace/hammad/3-tier-pipeline/kubemanifests.yaml'
                    }

			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}