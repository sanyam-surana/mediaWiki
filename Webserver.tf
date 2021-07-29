resource "aws_volume_attachment" "ebs_att1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.webSize.id
  instance_id = aws_instance.web1.id
}

resource "aws_instance" "web1" {
  ami               = "ami-027bdf1182290ac39"
  availability_zone = "us-west-2a"
  instance_type     = "t3.xlarge"
  vpc_id = aws_vpc.web.vpc_id

  tags = {
    Name = "Media_Wiki_Web"
  }
}

resource "aws_ebs_volume" "webSize" {    #200gb volume
  availability_zone = "us-west-2a"
  size              = 200
}