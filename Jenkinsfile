working_branch = "master"

pipeline {
    agent { label 'Windows_Node2'}
    stages {
        stage('Determine Branch'){
            steps {
                script {
                    // If its a pull request, CHANGE_ID will be set
                    // Then set the branch to the origin branch of the pull request
                    if(env.CHANGE_ID) {
                        working_branch = env.CHANGE_BRANCH
                    }
                    else {
                        working_branch = env.BRANCH_NAME
                    }
                }
            }
        }
        stage ('Build') {
            parallel {
                stage('BME280') {
                    when { changeset "CPLD_BME280_I2C/*"}
                    steps {
                    
                        build job: 'MAX10_BME280', parameters: [string(name: 'GIT_BRANCH', value: working_branch)]
                    }
                }
                stage('Mic_Encoder_Decoder') {
                    when { changeset "CPLD_Microphone_Array/*"}
                    steps {
                        build job: 'Q18P0_MAX10_Microphone_Array', parameters: [string(name: 'GIT_BRANCH', value: working_branch)]
                    }
                }
            }
        }
    }
}