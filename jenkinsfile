pipeline {
    agent any

    stages {
        stage('Hadolint Check') {
            steps {
                script {
                    // 执行 hadolint 检查脚本
                    sh 'chmod +x hadolint/hadolint_check.sh'
                    def checkOutput = sh(script: './hadolint/hadolint_check.sh', returnStdout: true).trim()
                    
                    // 设置 GitHub check
                    def checkName = 'Hadolint'
                    def conclusion = checkOutput.contains('ERROR') ? 'failure' : 'success'
                    
  
                        
                        echo "GitHub Checks API Response: ${response.status}"
                    }
                }
            }
        }

    }

    post {
        always {
            // 在这里添加任何需要在构建完成后执行的操作
            echo "Build completed. Performing post-build actions..."
            publishChecks name: 'example', title: 'Pipeline Check', summary: 'check through pipeline',
            text: 'you can publish checks in pipeline script',
            detailsURL: 'https://github.com/jenkinsci/checks-api-plugin#pipeline-usage',
            actions: [[label:'an-user-request-action', description:'actions allow users to request pre-defined behaviours', identifier:'an unique identifier']]
            // 例如，可以在这里清理工作空间或发送通知
            cleanWs()
        }
    }
}
