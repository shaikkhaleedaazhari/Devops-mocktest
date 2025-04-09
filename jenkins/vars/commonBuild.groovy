def call() {
    stage('Checkout') {
        checkout scm
    }

    stage('Unit Tests') {
        echo 'Running unit tests...'
        sh 'echo "Pretending to run tests..."'
    }

    stage('Deploy') {
        echo 'Deploying to environment...'
        sh 'echo "Pretending to deploy..."'
    }
}
