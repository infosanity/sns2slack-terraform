resource "aws_sns_topic" "slack-sns" {
  name = "post-to-slack"
}

resource "aws_sns_topic_subscription" "slack-sns-sub" {
  topic_arn = aws_sns_topic.slack-sns.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.sns2slack.arn
}