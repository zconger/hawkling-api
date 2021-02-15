pipeline {
  agent any
  stages {
    stage ("Checkout code") {
      steps {
        checkout scm
      }
    }
    stage ("Launch the Hawkling") {
      steps {
        sh 'docker-compose up --build --detach'
      }
    }
    stage ("Pull HawkScan Image") {
      steps {
        sh 'docker pull stackhawk/hawkscan'
      }
    }
    stage ("Run HawkScan Test") {
      environment {
        API_KEY = credentials('HAWK_API_KEY')
        AUTH_TOKEN = """${sh(
                        returnStdout: true,
                        script: './scripts/fetch-token.sh'
                     )}"""
      }
      steps {
        echo "${env.AUTH_TOKEN}"
//         sh '''
//           docker run -v ${WORKSPACE}:/hawk:rw -t \
//             -e API_KEY \
//             -e AUTH_TOKEN \
//             -e NO_COLOR="true" \
//             stackhawk/hawkscan
//         '''
      }
    }
  }
}
