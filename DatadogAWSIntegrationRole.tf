resource "aws_iam_role" "DatadogAWSIntegrationRole" {
  name = "DatadogAWSIntegrationRole"
  
  assume_role_policy = "${data.aws_iam_policy_document.DatadogAWSIntegrationRole.json}"
}

resource "aws_iam_policy" "DatadogAWSIntegrationPolicy" {
  name        = "DatadogAWSIntegrationPolicy"
  path        = "/"
  description = "DatadogAWSIntegrationPolicy"

  policy = "${data.aws_iam_policy_document.DatadogAWSIntegrationPolicyData.json}"
}

data "aws_iam_policy_document" "DatadogAWSIntegrationRole" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["${var.datadog_identifier}"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${var.datadog_shared_secret}"]
    }
  }
}

data "aws_iam_policy_document" "DatadogAWSIntegrationPolicyData" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:Describe*",
      "budgets:ViewBudget",
      "cloudfront:GetDistributionConfig",
      "cloudfront:ListDistributions",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "codedeploy:List*",
      "codedeploy:BatchGet*",
      "directconnect:Describe*",
      "dynamodb:List*",
      "dynamodb:Describe*",
      "ec2:Describe*",
      "ecs:Describe*",
      "ecs:List*",
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeTags",
      "elasticloadbalancing:Describe*",
      "elasticmapreduce:List*",
      "elasticmapreduce:Describe*",
      "es:ListTags",
      "es:ListDomainNames",
      "es:DescribeElasticsearchDomains",
      "health:DescribeEvents",
      "health:DescribeEventDetails",
      "health:DescribeAffectedEntities",
      "kinesis:List*",
      "kinesis:Describe*",
      "lambda:AddPermission",
      "lambda:GetPolicy",
      "lambda:List*",
      "lambda:RemovePermission",
      "logs:Get*",
      "logs:Describe*",
      "logs:FilterLogEvents",
      "logs:TestMetricFilter",
      "logs:PutSubscriptionFilter",
      "logs:DeleteSubscriptionFilter",
      "logs:DescribeSubscriptionFilters",
      "rds:Describe*",
      "rds:List*",
      "redshift:DescribeClusters",
      "redshift:DescribeLoggingStatus",
      "route53:List*",
      "s3:GetBucketLogging",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetBucketTagging",
      "s3:ListAllMyBuckets",
      "s3:PutBucketNotification",
      "ses:Get*",
      "sns:List*",
      "sns:Publish",
      "sqs:ListQueues",
      "support:*",
      "tag:GetResources",
      "tag:GetTagKeys",
      "tag:GetTagValues"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy_attachment" "DatadogAWSPolicyAttachment" {
  name       = "Allow Datadog PolicyAccess via Role"
  roles      = ["${aws_iam_role.DatadogAWSIntegrationRole.name}"]
  policy_arn = "${aws_iam_policy.DatadogAWSIntegrationPolicy.arn}"
}
