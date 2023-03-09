resource "aws_dynamodb_table" "dbtable" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  hash_key = var.dynamodb_hash_key
  # range_key = var.dynamodb_range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
        name = attribute.value.name
        type = attribute.value.type
    }
  }
}
