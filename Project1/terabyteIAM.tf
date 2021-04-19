# declare provider
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# create users2-4
resource "aws_iam_user" "terabyte02" {
  name = "terabyte02"
  path = "/system/"

  tags = {
    tag-key = "terabyte02"
  }
}

resource "aws_iam_access_key" "terabyte02" {
  user = aws_iam_user.terabyte02.name
}

resource "aws_iam_user" "terabyte03" {
  name = "terabyte03"
  path = "/system/"

  tags = {
    tag-key = "terabyte03"
  }
}

resource "aws_iam_access_key" "terabyte03" {
  user = aws_iam_user.terabyte03.name
}


# add users to group
resource "aws_iam_group_membership" "group-members" {
  name = "group-member"

  users = [
    aws_iam_user.terabyte02.name,
    aws_iam_user.terabyte03.name,
    "Terabyte1",
    "Terabyte2",
    "Terabyte3",
  ]

  group = aws_iam_group.terabyte-admin.name
}



resource "aws_iam_group" "terabyte-admin" {
  name = "terabyte-admin"
}

# create roles
resource "aws_iam_role" "admin" {
  name = "admin"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "terabyteP1"
  }
}

resource "aws_iam_policy" "admin_policy" {
  name        = "admin_policy"
  path        = "/"
  description = "Admin policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "admin" {
  name       = "test-attachment"
  roles      = [aws_iam_role.admin.name]
  groups     = [aws_iam_group.terabyte-admin.name]
  policy_arn = aws_iam_policy.admin_policy.arn
}
