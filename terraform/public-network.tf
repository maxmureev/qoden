##########################################################
# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.subnet_cidr, count.index)}"
  availability_zone = "${element(var.zones, count.index)}"
  count             = "${var.count_subnet}"

  tags = {
    Name = "${format("${var.env}-${element(var.alias, count.index)}-public-subnet-%02d", count.index)}"
  }
}

##########################################################
# Create Public Route Tables
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${var.count_subnet}"

  tags = {
    Name = "${format("${var.env}-public-route-table-%02d", count.index)}"
  }
}

##########################################################
# Create Public Route
resource "aws_route" "public" {
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
  count                  = "${var.count_subnet}"
}

##########################################################
# Associate The Routing Table To Public Subnet

resource "aws_route_table_association" "public" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  count          = "${var.count_subnet}"
}

##########################################################
# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.env}-igw"
  }
}
