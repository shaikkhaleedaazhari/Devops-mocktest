@Library('shared-lib') _   // Name from Jenkins Global Configuration

pipeline {
    agent any

    stages {
        stage('Build using Shared Library') {
            steps {
                commonBuild()  // This calls vars/commonBuild.groovy -> def call()
            }
        }
    }
}
