provider "aws" {
  # Configuration options
  region = "ap-south-1"
  # even after setting the profile below
  # the command "terraform plan/apply etc."
  # will only work if the "AWS_PROFILE"
  # environment variable is set using the
  # command "export AWS_PROFILE=terraform"
  # on a unix based OS
  profile = "terraform2"
}