#HTTPD - server01 inicialization
resource "aws_instance" "httpd-server01" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  tags = { 
   Name = "httpd-server01"
   }

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-httpd.rendered
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-central-1a"
  size              = 5
  type              = "io1"
  tags = {
    Name = var.APP_VOL_TAG
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = var.APP_VOL_NAME
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.httpd-server01.id
}

resource "aws_ebs_volume" "ebs-volume-2" {
  availability_zone = "eu-central-1a"
  size              = 500
  type              = "st1"
  tags = {
    Name = var.LOG_VOL_TAG
  }
}

resource "aws_volume_attachment" "ebs-volume-2-attachment" {
  device_name = var.LOG_VOL_NAME
  volume_id   = aws_ebs_volume.ebs-volume-2.id
  instance_id = aws_instance.httpd-server01.id
}

#HTTPD - server02 inicialization
resource "aws_instance" "httpd-server02" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  tags = { 
   Name = "httpd-server02"
   }

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-httpd.rendered

}

resource "aws_ebs_volume" "ebs-volume-3" {
  availability_zone = "eu-central-1a"
  size              = 5
  type              = "io1"
  tags = {
    Name = var.APP_VOL_TAG
  }
}

resource "aws_volume_attachment" "ebs-volume-3-attachment" {
  device_name = var.APP_VOL_NAME
  volume_id   = aws_ebs_volume.ebs-volume-3.id
  instance_id = aws_instance.httpd-server02.id
}

resource "aws_ebs_volume" "ebs-volume-4" {
  availability_zone = "eu-central-1a"
  size              = 500
  type              = "st1"
  tags = {
    Name = var.LOG_VOL_TAG
  }
}

resource "aws_volume_attachment" "ebs-volume-4-attachment" {
  device_name = var.LOG_VOL_NAME
  volume_id   = aws_ebs_volume.ebs-volume-4.id
  instance_id = aws_instance.httpd-server02.id
}


#LB-Serverinicialization
resource "aws_instance" "lb-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  tags = { 
   Name = "lb-server"
   }

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-lb.rendered
}