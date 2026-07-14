data "aws_iam_policy_document" "eks_velero" {

  statement {
    sid = "VeleroBucket"

    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-velero"
    ]
  }

  statement {
    sid = "VeleroObjects"

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-velero/*"
    ]
  }

  statement {
    sid = "EC2Snapshots"

    effect = "Allow"

    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_velero_policy" {
  name   = "${var.cluster_name}-velero-policy"
  policy = data.aws_iam_policy_document.eks_velero.json
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-velero-policy"
    }
  )
}
