
#SALT MASTER -Server inicialization
# resource "aws_instance" "salt-master-server" {
  # ami           = var.AMIS[var.AWS_REGION]
  # instance_type = var.INSTANCE_TYPE
  # tags = { 
   # Name = "salt-master-${var.ENV}-server"
   # }

  # the VPC subnet
  # subnet_id = element(var.PUBLIC_SUBNETS, 1)

  # the security group
  # vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  # key_name = "frankfurt_key_pair"
  
  # user data
  # user_data = data.template_cloudinit_config.cloudinit-salt-master.rendered
# }

#HTTPD - server01 inicialization
resource "aws_instance" "httpd-server01" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  tags = { 
   Name = "httpd-${var.ENV}-server01"
   }
   # depends_on = [aws_instance.salt-master-server]
  # the VPC subnet
  subnet_id = element(var.PRIVATE_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.httpd_server.id]

  # the public SSH key
  #key_name = aws_key_pair.mykeypair.key_name
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-httpd.rendered
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-central-1a"
  size              = 5
  type              = "gp2"
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
  instance_type = var.INSTANCE_TYPE
  tags = { 
   Name = "httpd-${var.ENV}-server02"
   }
   
  # depends_on = [aws_instance.salt-master-server]

  # the VPC subnet
  subnet_id = element(var.PRIVATE_SUBNETS, 1)

  # the security group
  vpc_security_group_ids = [aws_security_group.httpd_server.id]

  # the public SSH key
  #key_name = aws_key_pair.mykeypair.key_name
 
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-httpd.rendered

}

resource "aws_ebs_volume" "ebs-volume-3" {
  availability_zone = "eu-central-1b"
  size              = 5
  type              = "gp2"
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
  availability_zone = "eu-central-1b"
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
  instance_type = var.INSTANCE_TYPE
  tags = { 
   Name = "lb-${var.ENV}-server"
   }
  # depends_on = [aws_instance.salt-master-server]

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.httpd_server.id]

  # the public SSH key
  #key_name = aws_key_pair.mykeypair.key_name
   key_name = "frankfurt_key_pair"
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-lb.rendered
}

output "httpd-server01_ip" {
  description = "httpd-server01_ip"
  value       = aws_instance.httpd-server01.private_ip
}
output "httpd-server02_ip" {
  description = "httpd-server02_ip"
  value       = aws_instance.httpd-server02.private_ip
}