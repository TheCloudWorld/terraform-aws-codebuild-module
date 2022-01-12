resource "aws_codebuild_project" "codebuild_project" {
  count         = 1
  name          = var.codebuild_project_name
  description   = "spring boot microservices build project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type     = "CODEPIPELINE"
  }


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.log_group_name
      stream_name = var.log_stream_name
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_bucket_log}/build-log"
    }
  }
  source {
    type      = "CODEPIPELINE"
  }
  tags = {
    Environment = "dev"
  }
}