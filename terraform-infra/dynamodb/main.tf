resource "aws_dynamodb_table" "dbtable" {
  name             = var.table_name
  billing_mode     = "PROVISIONED" # PAY_PER_REQUEST is the other option
  read_capacity    = 1
  write_capacity   = 1
  hash_key         = var.attributes.sort_key
  range_key        = var.attributes.range_key
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = var.attributes.sort_key
    type = var.attributes.sort_type
  }
  attribute {
    name = var.attributes.range_key
    type = var.attributes.range_type
  }
}