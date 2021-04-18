
# create a vpc
resource "aws_vpc" "terabyte1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terabyte1-vpc"
  }
}

# create public subnet1-3 in three AZs
resource "aws_subnet" "public-subnet1" {
  vpc_id                  = "${aws_vpc.terabyte1.id}"
  cidr_block              = "10.0.0.0/21"
  map_public_ip_on_launch = "true" //it makes this a public subnet, default is "false"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id                  = "${aws_vpc.terabyte1.id}"
  cidr_block              = "10.0.8.0/21"
  map_public_ip_on_launch = "true" //it makes this a public subnet, default is "false"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_subnet" "public-subnet3" {
  vpc_id                  = "${aws_vpc.terabyte1.id}"
  cidr_block              = "10.0.16.0/21"
  map_public_ip_on_launch = "true" //it makes this a public subnet, default is "false"
  availability_zone       = "us-west-2c"

  tags = {
    Name = "public-subnet3"
  }
}

# create private subnet1-3 in three AZs
resource "aws_subnet" "private-subnet1" {
  vpc_id            = "${aws_vpc.terabyte1.id}"
  cidr_block        = "10.0.128.0/19"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id            = "${aws_vpc.terabyte1.id}"
  cidr_block        = "10.0.160.0/19"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_subnet" "private-subnet3" {
  cidr_block        = "10.0.192.0/19"
  availability_zone = "us-west-2c"
  vpc_id            = "${aws_vpc.terabyte1.id}"

  tags = {
    Name = "private-subnet3"
  }
}
