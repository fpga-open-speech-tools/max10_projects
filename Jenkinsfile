pipeline {
    agent any
    stages {
        stage ('Build') {
            parallel {
                stage('BME280') {
                    when { changeset "CPLD_BME280_I2C/*"}
                    steps {
                        build job: 'MAX10_BME280', parameters: [string(name: 'GIT_BRANCH', value: BRANCH_NAME)]
                    }
                }
                stage('Mic_Encoder_Decoder') {
                    when { changeset "CPLD_Microphone_Array/*"}
                    steps {
                        build job: 'Q18P0_MAX10_Microphone_Array', parameters: [string(name: 'GIT_BRANCH', value: BRANCH_NAME)]
                    }
                }
            }
        }
    }
}