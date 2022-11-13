resource "aws_dynamodb_table" "dbtable" {
  name           = var.table_name
  billing_mode   = "PROVISIONED" # PAY_PER_REQUEST is the other option
  read_capacity  = 1
  write_capacity = 1
  hash_key       = var.attributes[0].name
  range_key      = var.attributes[1].name
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
}