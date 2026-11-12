locals {
  vpc_first_ip = parseint(
    join("", [
      for octet in split(".", cidrhost(var.vpc_cidr, 0)) :
      format("%02x", tonumber(octet))
    ]),
    16
  )

  vpc_last_ip = parseint(
    join("", [
      for octet in split(".", cidrhost(var.vpc_cidr, -1)) :
      format("%02x", tonumber(octet))
    ]),
    16
  )

  subnet_ip_ranges = [
    for cidr in var.public_subnet_cidrs : {
      first = parseint(
        join("", [
          for octet in split(".", cidrhost(cidr, 0)) :
          format("%02x", tonumber(octet))
        ]),
        16
      )

      last = parseint(
        join("", [
          for octet in split(".", cidrhost(cidr, -1)) :
          format("%02x", tonumber(octet))
        ]),
        16
      )
    }
  ]

  subnet_pairs = flatten([
    for i, subnet_a in local.subnet_ip_ranges : [
      for j, subnet_b in local.subnet_ip_ranges : {
        overlaps = (
          subnet_a.first <= subnet_b.last &&
          subnet_b.first <= subnet_a.last
        )
      } if i < j
    ]
  ])
}

# Define the VPC and its IPv4 range
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  lifecycle {
    # CIDR containment validation
    precondition {
      condition = alltrue([
        for subnet_range in local.subnet_ip_ranges :
        subnet_range.first >= local.vpc_first_ip &&
        subnet_range.last <= local.vpc_last_ip
      ])

      error_message = "Every public subnet CIDR must fall entirely within the configured VPC CIDR range."
    }

    # Subnet overlap validation
    precondition {
      condition = alltrue([
        for pair in local.subnet_pairs :
        !pair.overlaps
      ])

      error_message = "Public subnet CIDR blocks must not overlap."
    }
  }

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Connect an internet gateway to the VPC
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Define the public subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
  }
}

# Define the route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Add the default IPv4 route to the internet gateway
resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate each subnet with the route table
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
