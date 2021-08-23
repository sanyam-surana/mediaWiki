resource "aws_security_group" "websg" { #web security Group
  name        = "websg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.web.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "appsg" {  #app security Group
  name        = "appsg"
  description = "need to tighten based on application"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
     cidr_blocks       = ["0.0.0.0/0"]
  } 
}

resource "aws_security_group" "dbsg" {  #Db security Group
  name        = "dbsg"
  description = "need to tighten after app deployment and Db connection"   

  ingress {
    from_port   = 443   
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  } 
}
