resource "aws_lambda_layer_version" "layer" {
  layer_name          = local.service_name
  compatible_runtimes = [var.runtime]
  filename            = filebase64sha256(local.filename)
  source_code_hash    = filebase64sha256(local.filename)
}