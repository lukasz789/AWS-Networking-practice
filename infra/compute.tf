# ------------------------------------------------------------------------------
# Public EC2 instance
# ------------------------------------------------------------------------------
resource "aws_key_pair" "public_instance" {
  key_name   = "${var.project_name}-public-instance-key"
  public_key = file("${path.module}/public_instance_key.pub")
}

resource "aws_instance" "public" {
  ami           = local.amazon_linux_2023_ami
  instance_type = local.instance_type

  subnet_id = aws_subnet.public.id

  # t3 instances are "unlimited" by default, but no need to have it in such basic project
  credit_specification {
    cpu_credits = "standard"
  }

  key_name               = aws_key_pair.public_instance.key_name
  vpc_security_group_ids = [aws_security_group.public_instance.id]
}

# ------------------------------------------------------------------------------
# Private EC2 instance
# ------------------------------------------------------------------------------
resource "aws_key_pair" "private_instance" {
  key_name   = "${var.project_name}-private-instance-key"
  public_key = file("${path.module}/private_instance_key.pub")
}

resource "aws_instance" "private" {
  ami           = local.amazon_linux_2023_ami
  instance_type = local.instance_type

  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false

  # t3 instances are "unlimited" by default, but no need to have it in such basic project
  credit_specification {
    cpu_credits = "standard"
  }

  key_name               = aws_key_pair.private_instance.key_name
  vpc_security_group_ids = [aws_security_group.private_instance.id]
}
