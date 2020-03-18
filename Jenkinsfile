pipeline {
    agent any
    parameters {
        string (
            defaultValue: '*',
            description: '',
            name : 'BRANCH_PATTERN')
        booleanParam (
            defaultValue: false,
            description: '',
            name : 'FORCE_FULL_BUILD')
    }

    stages {
        stage ('Build') {
            parallel {
                stage('BME280') {
                    when { changeset "CPLD_BME280_I2C/*"}
                    steps {
                        build job: 'Q18P0_MAX10_BME280', parameters: [string(name: 'GIT_BRANCH', value: BRANCH_NAME), string(name: 'PROJECT', value: 'CPLD_BME280_I2C'), string(name: 'DIRECTORY', value: 'CPLD_BME280_I2C')]
                    }
                }
                stage('Mic_Encoder_Decoder') {
                    when { changeset "CPLD_Microphone_Array/*"}
                    steps {
                        build job: 'Q18P0_MAX10_BME280', parameters: [string(name: 'GIT_BRANCH', value: BRANCH_NAME), string(name: 'PROJECT', value: 'Max10_System'), string(name: 'DIRECTORY', value: 'CPLD_Microphone_Array')]
                    }
                }
                
                // mac: {
                //     build job: 'full-build-mac', parameters: [string(name: 'GIT_BRANCH_NAME', value: BRANCH_NAME)]
                // },
                // windows: {
                //     build job: 'full-build-windows', parameters: [string(name: 'GIT_BRANCH_NAME', value: BRANCH_NAME)]
                // },
                }
        }
        stage ('Build Skipped') {
            when {
                expression {
                    GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                    return !(GIT_BRANCH == 'origin/master' || params.FORCE_FULL_BUILD)
                }
            }
            steps {
                echo 'Skipped full build.'
            }
        }
    }
}