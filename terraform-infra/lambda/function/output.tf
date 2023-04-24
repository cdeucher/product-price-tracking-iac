output "lambda_arn" {
  value = length(var.image_uri) > 0 ? aws_lambda_function.uri[0].arn : aws_lambda_function.code[0].arn
}
output "function_name" {
  value = length(var.image_uri) > 0 ? aws_lambda_function.uri[0].function_name : aws_lambda_function.code[0].function_name
}
output "invoke_arn" {
  value = length(var.image_uri) > 0 ? aws_lambda_function.uri[0].invoke_arn : aws_lambda_function.code[0].invoke_arn
}
