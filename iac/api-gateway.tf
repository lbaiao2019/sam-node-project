module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "${local.service_name}-api"
  description   = "HTTP API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  create_api_domain_name = false
  create_default_stage   = true

  # Access logs
  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.default.arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "POST /" = {
      lambda_arn             = aws_lambda_function.default.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
  }

  tags = {
    owner        = local.owner
    service_name = local.service_name
    managed_by   = local.managed_by
    envname      = local.envname
    versioning   = local.versioning
  }
}

resource "aws_cloudwatch_log_group" "default" {
  name = "/aws/apigateway/${local.service_name}-api"
}