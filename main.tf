data "tls_certificate" "tfe_certificate" {
  url = "https://${var.tfe_hostname}"
}


resource "aws_iam_openid_connect_provider" "tfe_provider" {
  url             = data.tls_certificate.tfe_certificate.url
  client_id_list  = [var.tfe_aws_audience]
  thumbprint_list = [data.tls_certificate.tfe_certificate.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "assume_role_tfe_oidc" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.tfe_provider.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.tfe_hostname}:aud"
      values   = ["${one(aws_iam_openid_connect_provider.tfe_provider.client_id_list)}"]
    }
    condition {
      test     = "StringLike"
      variable = "${var.tfe_hostname}:sub"
      values   = ["organization:${var.tfe_organization_name}:project:${var.tfe_project_name}:workspace:${var.tfe_workspace_name}:run_phase:*"]
    }
  }
}

resource "aws_iam_role" "tfe_oidc" {
  name               = "tfe-ds-oidc"
  assume_role_policy = data.aws_iam_policy_document.assume_role_tfe_oidc.json
}

# This policy is an example and should be modified to fit your needs.
data "aws_iam_policy_document" "tfe_oidc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "tfe_oidc" {
  name   = "tfe-ds-oidc"
  policy = data.aws_iam_policy_document.tfe_oidc.json
}


resource "aws_iam_role_policy_attachment" "tfe_oidc" {
  role       = aws_iam_role.tfe_oidc.name
  policy_arn = aws_iam_policy.tfe_oidc.arn
}
