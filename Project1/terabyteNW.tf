# set up Internet gateway
resource "aws_internet_gateway" "terabyte-igw" {
  vpc_id = "${aws_vpc.terabyte1.id}"

  tags = {
    Name = "terabyte-igw"
  }
}

# elastic ip
resource "aws_eip" "elastic_ip" {
  vpc = true
}

# NAT gateway
resource "aws_nat_gateway" "nat_gateway" {

  depends_on    = [aws_internet_gateway.terabyte-igw]
  allocation_id = aws_eip.elastic_ip.id        // elastic ip attaches to nat gateway
  subnet_id     = aws_subnet.public-subnet1.id // the subnet in which this nat gateway locate

  tags = {
    Name = "nat-gateway"
  }
}

# route table for Internet gateway
resource "aws_route_table" "IG_route" {

  vpc_id = aws_vpc.terabyte1.id //IGW attach to vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terabyte-igw.id
  }

  tags = {
    Name = "IG-route-table"
  }
}

resource "aws_main_route_table_association" "ar" {
  vpc_id         = aws_vpc.terabyte1.id
  route_table_id = aws_route_table.IG_route.id
}

# route table for NAT gateway
resource "aws_route_table" "nat_route" {
  vpc_id = aws_vpc.terabyte1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  

  tags = {
    Name = "NAT-route-table"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "routetable_to_public_subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.IG_route.id
}

resource "aws_route_table_association" "routetable_to_public_subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.IG_route.id
}

resource "aws_route_table_association" "routetable_to_public_subnet3" {
  subnet_id      = aws_subnet.public-subnet3.id
  route_table_id = aws_route_table.IG_route.id
}

resource "aws_route_table_association" "routetable_to_private_subnet1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.nat_route.id
}

resource "aws_route_table_association" "routetable_to_private_subnet2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.nat_route.id
}

resource "aws_route_table_association" "routetable_to_private_subnet3" {
  subnet_id      = aws_subnet.private-subnet3.id
  route_table_id = aws_route_table.nat_route.id
}
