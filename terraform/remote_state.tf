terraform {
  required_version = ">= 0.12.0"
  backend "local" {
    path = "terraform.tfstate"
  }
}
