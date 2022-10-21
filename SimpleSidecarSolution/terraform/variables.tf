variable "service_name" {
  description = "Name to be used for ECS Service"
  default = "dark-flask-api"
}

variable "region" {
  description = "Region to deploy infrastructure"
  default = "us-east-1"
}

variable "api_image_url" {
    description = "URL for the containerized API you wish to deploy"
    default = "763787222038.dkr.ecr.us-east-1.amazonaws.com/flask_api:latest"
}

variable "api_cpu" {
    description = "CPU and Memory must line up with Fargate requirements. Suggested 512 (.5 vCPU) to match 1-4GB memory or 1024 (1 vCPU) to match 2-8GB memory here."
    default = "512"
}

variable "api_memory" {
    description = "CPU and Memory must line up with Fargate requirements. Suggested 1-4GB to match 512 (.5vCPU) memory or 2-8GB to match 1024 (1 vCPU) memory here."
    default = "1 GB"
}