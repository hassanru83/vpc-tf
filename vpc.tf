
resource "aws_vpc" "my-teraformvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  count = 4
  vpc_id     = aws_vpc.my-teraformvpc.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name = "subnet-${count.index}"
  }
}
