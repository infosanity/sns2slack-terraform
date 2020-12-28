# SNS to Slack Pipeline
## Summary
Quick proof of concept for feeding comms from SNS topic into a Slack channel, deployed via Terraform

## Lambda
Lambda function itself 'borrowed' from Beibei Yang's [sns-to-slack repo](https://github.com/beibeiyang/sns-to-slack)

### lambda..tf
Bundles python code of the lambda, and creates a new function that is triggered by messages posted to the SNS topic

### Slack config file
Distribution version of the lambda's config file supplied [lambda.cfg-dist](lambda/slack_handler/lambda.cfg-dist). Rename to just lambda.cfg, and update both the _endpoint_ and _channel_ variables to match your [Slack webhook](https://api.slack.com/messaging/webhooks)

## sns..tf
Creates a new SNS Topic, and subscribes the appropriate lambda function
