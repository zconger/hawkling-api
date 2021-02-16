pipeline {
  agent any
  triggers { cron('*/5 * * * *') }
  stages {
    stage ("Checkout code") {
      steps {
        checkout scm
      }
    }
    stage ("Launch Hawkling") {
      steps {
        sh 'docker-compose down'
        sh 'docker-compose up --build --detach'
      }
    }
    stage ("Pull HawkScan") {
      steps {
        sh 'docker pull stackhawk/hawkscan'
      }
    }
    stage ("Run HawkScan") {
      environment {
        API_KEY = credentials('HAWK_API_KEY')
        AUTH_TOKEN = """${sh(
                        returnStdout: true,
                        script: './scripts/fetch-token.sh'
                     )}"""
      }
      steps {
        sh '''
          docker run -v ${WORKSPACE}:/hawk:rw -t \
            --network host \
            -e API_KEY \
            -e AUTH_TOKEN \
            -e NO_COLOR="true" \
            stackhawk/hawkscan stackhawk.yml stackhawk-token-only.yml
        '''
      }
    }
    stage ("Stop Hawkling") {
      steps {
        sh 'docker-compose down'
      }
    }
  }
}
