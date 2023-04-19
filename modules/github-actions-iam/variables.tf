variable "project_prefix" {
  description = "Name prefix that is used for resource naming"
}
variable "github_workspace" {
  description = "The github workspace name. e.g.:, If https://github.com/SamTowne/TerraformAWSBootstrap is the repo URL, set as `SamTowne`"
}
variable "github_repo" {
  description = "The github repository name. e.g.: If https://github.com/SamTowne/TerraformAWSBootstrap is the repo URL, set as `TerraformAWSBootstrap`"
}