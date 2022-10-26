//Stores dark_api_endpoint.json from local filesystem to AWS Secrets Manager via default Secrets Manager KMS key.
resource "aws_secretsmanager_secret" "api_identity" {
  name = "${var.token_secret_name}"
}

resource "aws_secretsmanager_secret_version" "api_identity_version" {
  secret_id     = aws_secretsmanager_secret.api_identity.id
  secret_string = file("${path.module}/../identity_token_goes_here/dark_api_endpoint.json")
}