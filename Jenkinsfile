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
    options { checkoutToSubdirectory('CPLD_BME280_I2C') }

    stages {
        stage ('Prepare') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "origin/${params.BRANCH_PATTERN}"]],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[$class: 'LocalBranch']],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        credentialsId: 'b27e7477-aab1-4f4e-a05c-23cd05d217ee',
                        url: 'https://github.com/fpga-open-speech-tools/max10_projects.git']]])
            }
        }

        stage ('Build') {
            when {
                expression {
                    GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                    return GIT_BRANCH == 'origin/master' || params.FORCE_FULL_BUILD
                }
            }
            steps {
                // Freestyle build trigger calls a list of jobs
                // Pipeline build() step only calls one job
                // To run all three jobs in parallel, we use "parallel" step
                // https://jenkins.io/doc/pipeline/examples/#jobs-in-parallel
                parallel (
                    linux: {
                        build job: 'full-build-linux', parameters: [string(name: 'GIT_BRANCH_NAME', value: GIT_BRANCH)]
                    },
                    mac: {
                        build job: 'full-build-mac', parameters: [string(name: 'GIT_BRANCH_NAME', value: GIT_BRANCH)]
                    },
                    windows: {
                        build job: 'full-build-windows', parameters: [string(name: 'GIT_BRANCH_NAME', value: GIT_BRANCH)]
                    },
                    failFast: false)
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