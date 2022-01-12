data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["default_vpc"]
  }
}
data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.vpc_available.id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}
data "aws_security_group" "tcw_sg" {
  filter {
    name   = "tag:Name"
    values = ["sg"]
  }
}