# ------------------------------------------------------------------------------
# Security group for the public EC2 instance
# ------------------------------------------------------------------------------
resource "aws_security_group" "public_instance" {
  name        = "${var.project_name}-public-instance-sg"
  description = "Security group for the public EC2 instance"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_public_instance" {
  security_group_id = aws_security_group.public_instance.id
  description       = "Allow SSH inbound traffic from anywhere"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_to_private_instance" {
  security_group_id            = aws_security_group.public_instance.id
  referenced_security_group_id = aws_security_group.private_instance.id
  description                  = "Allow outbound SSH to the private instance security group"

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

# ------------------------------------------------------------------------------
# Security group for the private EC2 instance
# ------------------------------------------------------------------------------
resource "aws_security_group" "private_instance" {
  name        = "${var.project_name}-private-instance-sg"
  description = "Security group for the private EC2 instance"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_private_instance" {
  security_group_id            = aws_security_group.private_instance.id
  description                  = "Allow inbound SSH from the public instance security group"
  referenced_security_group_id = aws_security_group.public_instance.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_https_private_instance" {
  security_group_id = aws_security_group.private_instance.id
  description       = "Allow outbound HTTPS to any IPv4 destination"
  cidr_ipv4         = "0.0.0.0/0"

  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}