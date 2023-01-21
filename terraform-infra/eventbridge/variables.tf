variable "project" {
  type        = string
  description = "The name of the environment to create"
}
variable "event_name" {
  type        = string
  description = "The name of the queue to create"
}
variable "tags" {
  type        = map(string)
  description = "The tags to apply to the resources"
}
variable "schedule" {
  type        = string
  description = "The schedule to run the event"
  default     = "rate(1 day)"
}
variable "lambda_arns" {
  type        = list(string)
  description = "Lambda arns to attach to the queue"
  default     = []
}