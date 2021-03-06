pipeline{

    agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_cred')
        BUILD_NAME= 'latest'
        REPO_NAME= 'hammaddaoud/nisum_assignment-1'
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
				sh 'docker build -t $REPO_NAME-frontend:$BUILD_NAME ./frontend/'
                echo 'Docker image created for frontend app'
			}
		}

		stage('Build-Backend') {

			steps {
				sh 'docker build -t $REPO_NAME-backend:$BUILD_NAME ./backend/'
                echo 'Docker image created for backend app'
			}
		}

		stage('Build-Gateway') {

			steps {
				sh 'docker build -t $REPO_NAME-gateway:$BUILD_NAME ./gateway/'
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
				sh 'docker push $REPO_NAME-frontend:$BUILD_NAME'
                sh 'docker push $REPO_NAME-backend:$BUILD_NAME'
                sh 'docker push $REPO_NAME-gateway:$BUILD_NAME'

			}
		}
		stage('K8S-Deployment') {

			steps {

                withCredentials([kubeconfigFile(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) { 
                    
                    sh 'kubectl apply -f kubemanifests.yaml'
                    }

			}
		}
	}

	post {
		always {
            sh 'docker rmi $REPO_NAME-frontend:$BUILD_NAME $REPO_NAME-backend:$BUILD_NAME $REPO_NAME-gateway:$BUILD_NAME'
			sh 'docker logout'
		}
	}

}