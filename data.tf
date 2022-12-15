data "terraform_remote_state" "management" {
  backend = "s3"
  config {
    bucket = "b51-tf-remote-state-bucket-afs"
    key    = "vpc/${var.env}/terraform.tfstate"
    region = "us-east-1"
  }
}