resource "aws_sns_topic" "notify_topic" {
  name = "notify_topic"
  tags = {
    project = var.tag
  }
}

resource "aws_sns_topic_subscription" "email_notification" {
  topic_arn = aws_sns_topic.notify_topic.arn
  protocol  = "email"
  endpoint  = "atfry@example.com"
}

output "sns_topic_arn" {
  value = aws_sns_topic.notify_topic.arn
}