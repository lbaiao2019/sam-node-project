module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  runtime       = var.runtime
  function_name = "${local.service_name}-lambda"
  handler       = "index.lambdaHandler"
  publish       = true
  lambda_role   = aws_iam_role.default.arn

  local_existing_package = "./tmp/code.zip"

  layers = [
    aws_lambda_layer_version.layer.arn
  ]

  allowed_triggers = {
    APIGatewayAny = {
      statement_id = "AllowExecutionFromAPIGateway"
      principal    = "apigateway.amazonaws.com"
    }
  }

  environment_variables = {
    S3_BUCKET = "${local.service_name}-bucket"
  }

  tags = {
    owner        = local.owner
    service_name = local.service_name
    managed_by   = local.managed_by
    envname      = local.envname
    versioning   = local.versioning
  }
}

resource "aws_iam_role" "default" {
  name = "${local.service_name}_role"

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


data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.service_name}/*",
    ]
  }
}

resource "aws_iam_policy" "default" {
  name   = "${local.service_name}_policy"
  policy = data.aws_iam_policy_document.default.json
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}
