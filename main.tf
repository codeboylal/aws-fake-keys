# Creating EC2 Instances fullly working with terraform

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
  required_version = ">= 1.2.0"
}

resource "aws_instance" "my_ec2_instance" {

  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"

Access key ID: 	AKIA4WVUNIYLQLRAAAAA
Secret access key: 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

  key_name = "test-key"

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "test-server"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow inbound SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}


# # Creating S3 Bucket with terraform

# resource "aws_s3_bucket" "new-example" {
#   bucket = "my-tf-test-bucket-7654321"

#   tags = {
#     Name        = "My bucket_new"
#     Environment = "Dev"
#   }
# }
