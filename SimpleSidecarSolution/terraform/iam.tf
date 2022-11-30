//Task Execution Role with access to Secrets Manager
resource "aws_iam_role" "demo_api_task_execution_role" {
  name = "${var.service_name}-task-execution-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


resource "aws_iam_policy" "demo_api_execution_policy" {
  name        = "${var.service_name}-execution-policy"
  description = "This policy allows ECS to deploy"
 
  policy = data.aws_iam_policy_document.demo_api_execution_policy_doc.json
}


data "aws_iam_policy_document" "demo_api_execution_policy_doc" { //TODO: Tighten Permissions
  statement {
    effect  = "Allow"
    actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    effect  = "Allow"
    actions = [
        "secretsmanager:*",
        "kms:DescribeKey",
        "kms:ListAliases",
        "kms:ListKeys",
        "tag:GetResources"
    ]
    resources = [
      "*",
    ]
  }
}


//TODO: Create KMS Key for secret
//TODO: Create Secret

resource "aws_iam_role_policy_attachment" "execution-attach" {
  role       = aws_iam_role.demo_api_task_execution_role.name
  policy_arn = aws_iam_policy.demo_api_execution_policy.arn
}

// Task Role

resource "aws_iam_role" "task_role" {
  name               = "demo_api_task_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}