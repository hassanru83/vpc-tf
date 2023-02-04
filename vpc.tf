
resource "aws_vpc" "my-teraformvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  count      = 4
  vpc_id     = aws_vpc.my-teraformvpc.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}

data "aws_subnet" "name" {
  filter {
    name = "tag:Name"
    values = ["subnet-2"]
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-0b0dcb5067f052a63" # us-east-1
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.name.id
}