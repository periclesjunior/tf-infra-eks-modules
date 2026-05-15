resource "aws_s3_bucket" "aws_velero" {
  bucket        = "${var.cluster_name}-velero"
  force_destroy = true

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-velero"
    }
  )

}
