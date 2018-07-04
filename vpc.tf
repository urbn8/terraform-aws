
terraform {
  backend "consul" {
    address = "192.168.10.51:8500"
    scheme  = "http"
    path    = "vpc-urbn8/terraform_state"
  }
}


# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "urbn8-vpc"
  }
}

# Define the public and private subnet Zone A
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Public Subnet-${var.zones[0]}"
  }
}
resource "aws_subnet" "private-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Private Subnet-${var.zones[0]}"
  }
}
# Define the public and private subnet Zone B
resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Public Subnet-${var.zones[1]}"
  }
}
resource "aws_subnet" "private-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Private Subnet-${var.zones[1]}"
  }
}
# Define the public and private subnet Zone C
resource "aws_subnet" "public-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Public Subnet-${var.zones[2]}"
  }
}
resource "aws_subnet" "private-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Private Subnet-${var.zones[2]}"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC-IGW-URBN8"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  route {
    cidr_block = "192.168.9.0/24"
    gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  }
  route {
    cidr_block = "192.168.10.0/24"
    gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  }

  tags {
    Name = "Public-Subnet-RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt-subnet-a" {
  subnet_id = "${aws_subnet.public-subnet-a.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt-subnet-b" {
  subnet_id = "${aws_subnet.public-subnet-b.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt-subnet-c" {
  subnet_id = "${aws_subnet.public-subnet-c.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}


#Create Virtual Private Gateway
resource "aws_vpn_gateway" "vpn_gateway" {
  tags {
    Name = "EU-VPN-GW"
  }
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = "${aws_vpc.default.id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
}


resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "${var.customer_gateway}"
  type       = "ipsec.1"

  tags {
    Name = "VN_VNPT"
  }
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
  tags {
    Name = "VNOFFICE"
  }
}
