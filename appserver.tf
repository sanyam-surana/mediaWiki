resource "aws_volume_attachment" "ebs_att2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.appSize.id
  instance_id = aws_instance.app1.id
}

resource "aws_instance" "app1" {
  ami               = "ami-027bdf1182290ac39"
  availability_zone = "us-west-2a"
  instance_type     = "t3.xlarge"
  vpc_id = aws_vpc.app.vpc_id
  tags = {
    Name = "Media_Wiki_App"
  }

 provisioner "remote-exec" {
    inline = [
      "aws s3 cp <bucketpath> <destination>",
      "unzip mediawiki.zip",
      ",/mediawiki.exe",
    ]
    #assuming mediawiki zip file is in S3 otherwise you can use wget command to fetch latest version from website
  }

}

resource "aws_ebs_volume" "appSize" {    #200gb volume
  availability_zone = "us-west-2a"
  size              = 200
}