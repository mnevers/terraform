# resource "aws_s3_bucket" "example"{
#     bucket = "mnevers-bucket"
#     tags = {
#         Name = "mnevers-bucket"
#     }
# }

# resource "aws_s3_bucket_versioning" "versioning_example" {
#     bucket = aws_s3_bucket.example.id
#     versioning_configuration {
#         status = "Enabled"
#     }
# }

# resource "aws_s3_bucket_public_access_block" "example-acc" {
#     bucket = aws_s3_bucket.example.id

#     block_public_acls = true
#     block_public_policy = true
#     ignore_public_acls = true
#     restrict_public_buckets = true
# }