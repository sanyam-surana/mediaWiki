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
      cd /
      wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
      gpg --verify mediawiki-1.36.1.tar.gz.sig mediawiki-1.36.1.tar.gz
      tar -zxf /home/username/mediawiki-1.36.1.tar.gz
      ln -s mediawiki-1.36.1/ mediawiki
     firewall-cmd --permanent --zone=public --add-service=http
     firewall-cmd --permanent --zone=public --add-service=https
     systemctl restart firewalld
    ]

  }

}

resource "aws_ebs_volume" "appSize" {    #200gb volume
  availability_zone = "us-west-2a"
  size              = 200
}