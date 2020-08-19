working_branch = "master"

pipeline {
    agent { label 'Windows_Node2'}
    stages {
        stage ('Build') {
            steps{
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
}