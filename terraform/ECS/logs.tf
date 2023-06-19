# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "test_log_group" {
  name              = "/ecs/test-app"
  retention_in_days = 30

  tags = {
    Name = "test-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "test_log_stream" {
  name           = "test-log-stream"
  log_group_name = aws_cloudwatch_log_group.test_log_group.name
}