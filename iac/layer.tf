resource "aws_lambda_layer_version" "layer" {
  depends_on          = [null_resource.build]
  layer_name          = local.service_name
  compatible_runtimes = [var.runtime]
  filename            = "/tmp/node_modules.zip"
  source_code_hash    = base64sha256("/tmp/node_modules.zip")
}