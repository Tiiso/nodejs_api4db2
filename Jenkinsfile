pipeline {
  agent {
    docker {
      image 's390x/node:20-bullseye'
      args '-p 3000:3000'
    }
  }
  environment {
    LD_LIBRARY_PATH = "/usr/src/app"
  }
  stages {
    stage('Install build tools') {
      steps {
        sh '''
          apt-get update && \
          apt-get install -y python3 make g++ gcc curl && \
          apt-get clean && \
          rm -rf /var/lib/apt/lists/*
        '''
      }
    }
    stage('Build') {
      steps {
        sh 'npm install'
      }
    }
  }
}
