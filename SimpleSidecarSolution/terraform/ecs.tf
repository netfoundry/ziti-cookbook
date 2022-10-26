// Spin up a single ECS Cluster and service with no load balancer
resource "aws_ecs_cluster" "dark_api" {
  name = "${var.service_name}-cluster"
}

resource "aws_ecs_service" "dark_api" {
  name            = "${var.service_name}-service"
  cluster         = aws_ecs_cluster.dark_api.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.dark-api.arn
  desired_count   = 1

  network_configuration {
    subnets = [aws_subnet.private_a.id, aws_subnet.private_b.id]
    security_groups = [aws_security_group.zero_ingress.id]
    assign_public_ip = true //TODO: This fixed the Secrets Manager Issue
  }

  depends_on      = [aws_iam_role.dark_api_task_execution_role]
}

resource "aws_ecs_task_definition" "dark-api" {
  family = "dark-api-family"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.dark_api_task_execution_role.arn
  task_role_arn =  aws_iam_role.task_role.arn
  network_mode = "awsvpc"
  cpu = 512
  memory = 1024
  container_definitions = jsonencode([
    {
      name      = "ziti-tunneller"
      image     = "openziti/ziti-host"
      cpu       = 256
      memory    = 512
      essential = true
      secrets   = [
      {
        valueFrom = "arn:aws:secretsmanager:${var.region}:${var.aws_account}:secret:${var.token_secret_name}",
        name      = "ZITI_IDENTITY_JSON" //this name is for local environment variable use and does not need to change
      }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group = aws_cloudwatch_log_group.dark_api.name ,
        awslogs-region = var.region,
        awslogs-stream-prefix = "dark_api"
      }
    }
    },
    {
      name      = "your-api"
      image     = var.api_image_url
      cpu       = 256
      memory    = 512
      essential = true
      logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group = aws_cloudwatch_log_group.dark_api.name ,
        awslogs-region = var.region,
        awslogs-stream-prefix = "dark_api"
      }
    }
    }
  ])
}


// Creates the log group for fargate logs
resource "aws_cloudwatch_log_group" "dark_api" {
  name = "/ecs/fargate_log_group"
}
