resource "aws_sqs_queue" "data_queue" {
  name = "data_queue"
  tags = {
    project = var.tag
  }
}

output "sqs_queue_url" {
  value = aws_sqs_queue.data_queue.id
}