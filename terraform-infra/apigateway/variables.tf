variable "project" {
  type        = string
  description = "The project name"
}
variable "stage" {
  type    = string
  default = "v1"
}
variable "sub_domain" {
  type        = string
  description = "The subdomain of the application"
}
variable "domain" {
  type        = string
  description = "The domain of the application"
}
variable "tags" {
  type        = map(string)
  description = "Tags para serem aplicadas em todos os recursos"
}