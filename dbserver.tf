resource "aws_volume_attachment" "ebs_att3" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.dbSize.id
  instance_id = aws_instance.Db1.id
}

resource "aws_instance" "Db1" {
  ami               = "ami-027bdf1182290ac39"
  availability_zone = "us-west-2a"
  instance_type     = "t3.xlarge"
  vpc_id = aws_vpc.db.vpc_id

  tags = {
    Name = "Media_Wiki_DB"
  }
}

resource "aws_ebs_volume" "dbSize" {  #500gb volume
  availability_zone = "us-west-2a"
  size              = 500
  type              = "io2"
  encrypted         = true
}