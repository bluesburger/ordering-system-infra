resource "aws_sqs_queue" "order_paid_queue" {
  name                        = "order-paid.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_paid_queue_policy" {
  queue_url = aws_sqs_queue.order_paid_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_paid_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "order_in_production_queue" {
  name                        = "order-in-production.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_in_production_queue_policy" {
  queue_url = aws_sqs_queue.order_in_production_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_in_production_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "order_produced_queue" {
  name                        = "order-produced.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_produced_queue_policy" {
  queue_url = aws_sqs_queue.order_produced_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_produced_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "order_delivering_queue" {
  name                        = "order-delivering.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_delivering_queue_policy" {
  queue_url = aws_sqs_queue.order_delivering_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_delivering_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "order_delivered_queue" {
  name                        = "order-delivered.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_delivered_queue_policy" {
  queue_url = aws_sqs_queue.order_delivered_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_delivered_queue.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "order_canceled_queue" {
  name                        = "order-canceled.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue_policy" "order_canceled_queue_policy" {
  queue_url = aws_sqs_queue.order_canceled_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.order_canceled_queue.arn
      }
    ]
  })
}