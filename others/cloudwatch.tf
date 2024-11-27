resource "aws_cloudwatch_event_rule" "rds_check_schedule" {
  name        = "rds-check-schedule"
  description = "Run Lambda function every 1 minute"
  schedule_expression = "rate(1 minute)"
  tags = {
    project = var.tag
  }
}

resource "aws_cloudwatch_event_target" "rds_lambda_target" {
  rule      = aws_cloudwatch_event_rule.rds_check_schedule.name
  arn       = var.notify_admin_arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.notify_admin
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rds_check_schedule.arn
}

resource "aws_cloudwatch_metric_alarm" "rds_alarm" {
  alarm_name          = "RDSCPUUtilizationHigh"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  statistic           = "Average"
  period              = 300
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  alarm_actions       = [aws_sns_topic.notify_topic.arn]
  tags = {
    project = var.tag
  }
}