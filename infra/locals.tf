locals {
  vpc_cidr = "10.0.0.0/24"

  public_subnet_cidr = cidrsubnet(
    local.vpc_cidr,
    3,
    0
  ) # 10.0.0.0/27

  private_subnet_cidr = cidrsubnet(
    local.vpc_cidr,
    3,
    1
  ) # 10.0.0.32/27

  amazon_linux_2023_ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"

  instance_type = "t3.micro"
}