variable "project" {
    type = string
    description = "The name of the environment to create"
}
variable "tags" {
    type = map(string)
    description = "The tags to apply to the resources"
}
variable "lambdas" {
    type = list(object({lambda_arn = string, function_name = string, invoke_arn = string}))
    description = "Lambda Object"
    default = []
}