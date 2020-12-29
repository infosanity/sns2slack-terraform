output "sns-arn" {
  value = aws_sns_topic.slack-sns.arn
}

resource "aws_ssm_parameter" "sns2slack-arn" {
  name  = "/projects/sns2slack/topic-arn"
  type  = "String"
  description = "Deployed from https://github.com/infosanity/sns2slack-terraform"
  value = aws_sns_topic.slack-sns.arn
}