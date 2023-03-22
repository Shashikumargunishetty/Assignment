pipeline{
agent any

stages{
	stage('scm'){
		steps{
			git credentialsId: 'github_service_account_passwd', url: 'https://github.com/Shashikumargunishetty/Assignment.git'		
		}

	}
	stage('build'){
		steps{
		 sh ''' cd assignment && npm install '''
	
		}


	}
	stage('unit tests'){
		steps {
		 sh ''' echo "run the unit tests" '''
		}
	

	}

	stage('integration tests'){
		steps{
		 sh ''' echo "Run integration tests" '''

		}
	}
	stage('Build docker image'){
		steps{
			sh ''' cd assignment && docker build -t assignment-image:${BUILDNUMBER} . '''

		}


	}
	stage('publish Docker image'){
		steps{
			sh ''' docker push assignment-image:${BUILDNUMBER} '''

		}


	}
	stage('Input'){
		steps{
			input('Do you want to proceed?')

		}
	}
	stage('Deploy the code'){
		steps{
			sh ''' sh deploy_script.sh '''
		}
	}


}

}
