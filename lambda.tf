data "archive_file" "lambda_slack_archive" {
  type        = "zip"
  source_dir  = "lambda/slack_handler/"
  output_path = "lambda/slack_handler.zip"
}

resource "aws_lambda_function" "sns2slack" {
  filename      = "lambda/slack_handler.zip"
  function_name = "sns2slack"
  role          = aws_iam_role.sns2slack_role.arn
  handler       = "sns2slack.handler"
  runtime       = "python3.8"
}

resource "aws_iam_role" "sns2slack_role" {
  name               = "iam_for_sns2slack"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambdaBasicExecution" {
  role       = aws_iam_role.sns2slack_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "snsPermissions" {
  statement_id  = "snsPerms"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sns2slack.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack-sns.arn
}