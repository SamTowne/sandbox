data "aws_iam_policy_document" "github" {
statement {
effect = "Allow"
actions = ["sts:AssumeRoleWithWebIdentity"]

principals {
type = "Federated"
identifiers = ["arn:aws:iam::272773485930:oidc-provider/token.actions.githubusercontent.com"]
}

condition {
test = "StringEquals"
variable = "token.actions.githubusercontent.com:aud"
values = ["sts.amazonaws.com"]
}

condition {
test = "StringLike"
variable = "token.actions.githubusercontent.com:sub"
values = ["repo:${var.github_workspace}/${var.github_repo}:*"]
}
}
}

resource "aws_iam_role" "github" {
name = "${var.project_prefix}-github-oidc"
assume_role_policy = data.aws_iam_policy_document.github.json
}

resource "aws_iam_policy_attachment" "AdministratorAccess" {
  name       = "AdministratorAccess"
  roles      = [aws_iam_role.github.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}