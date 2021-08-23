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

provisioner "remote-exec" {
    inline = [
    cd /
    yum install centos-release-scl
    yum install httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml mariadb-server mariadb 
    systemctl start mariadb
    mysql_secure_installation
    mysql -u root -p
    CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'NewXYZ';
    CREATE DATABASE firstdata;
    GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';
    FLUSH PRIVILEGES;
    SHOW DATABASES;
    SHOW GRANTS FOR 'wiki'@'localhost';
    exit
    ]
   
  }