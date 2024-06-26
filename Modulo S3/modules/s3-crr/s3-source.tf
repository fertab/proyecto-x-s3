data "aws_iam_policy_documet" "source_replication_role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["s3.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "source_replication_policy" {
    statement {
      actions = [ 
        "s3:GetReplicationConfiguration",
        "s3:ListBucket",
       ]

       resources = [
        local.source_bucket_arn,
       ]
    }

    statement {
      actions = [ 
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
       ]
    resources = [
        local.source_bucket_object_arn,
    ]
    }

    statement {
        actions = [
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ObjectOwnerOverrideToBucketOwner",
        ]
        resources = [
            local.dest_bucket_object_arn,
        ]
    }
}


resource "aws_iam_role" "source_replication" {
  provider = aws.source
  name = "${local.replication_name}-replication-role"
  assume_role_policy = data.aws_iam_policy_document.source_replication_role.json
}

resource "aws_iam_role_policy_attachment" "source_replication" {
    provider = aws.source
    role = aws_iam_role.source_replication.name
    policy_arn = aws_iam_policy.source_replication.arn
}

# S3 Source bucket

resource "aws_s3_bucket" "source" {
    provider = aws.source
    bucket = var.source_bucket_name
    versioning {
      enabled = true
    }

    replication_configuration {
      role = aws_iam_role.source_replication.arn

      rules {
        id = local.replication_name
        status = "Enabled"
        priority = var.priority
        prefix = var.replicate_prefix
        destination {
          bucket = local.dest_bucket_arn
          storage_class = "STANDARD"

          access_control_translation {
            owner = "Destination"
          }

          account_id = data.aws_caller_identity.dest.account_id
        }
      }
    }
}

























