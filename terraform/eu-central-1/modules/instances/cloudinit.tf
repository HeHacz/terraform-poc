#cloudinit config
data "template_file" "salt-minion-install" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/init.cfg")
}

data "template_file" "salt-minion-config" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/salt-minion-config.sh")
  # vars = {
  # MASTER_IP = aws_instance.salt-master-server.private_ip
  # }


data "template_file" "salt-minion-config" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/lb.sh")
  vars = {
  HTTPD01_IP = aws_instance.httpd-server01.private_ip
  HTTPD02_IP = aws_instance.httpd-server02.private_ip
  }
}

data "template_file" "volumes-mount" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/volumes.sh")
    vars = {
    APP_DEVICE = var.APP_VOL_NAME
    LOG_DEVICE = var.LOG_VOL_NAME	
  }
}


# data "template_file" "salt-master-install" {
  # template = file("./terraform/eu-central-1/modules/instances/scripts/salt-init.cfg")
# }

# data "template_file" "salt-master-config" {
  # template = file("./terraform/eu-central-1/modules/instances/scripts/salt-master-config.sh")
# }

data "template_cloudinit_config" "cloudinit-httpd" {
  gzip          = false
  base64_encode = false

   part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.salt-minion-install.rendered
  }
  
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.volumes-mount.rendered
  }
  part { 
    content_type = "text/x-shellscript"
    content      = data.template_file.salt-minion-config.rendered
    }
}


data "template_cloudinit_config" "cloudinit-lb" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.salt-minion-install.rendered
  }
  
  part { 
    content_type = "text/x-shellscript"
    content      = data.template_file.salt-minion-config.rendered
    }
}


# data "template_cloudinit_config" "cloudinit-salt-master" {
  # gzip          = false
  # base64_encode = false

  # part {
    # filename     = "salt-init.cfg"
    # content_type = "text/cloud-config"
    # content      = data.template_file.salt-master-install.rendered
  # }
  
    # part {
    # content_type = "text/x-shellscript"
    # content      = data.template_file.salt-master-config.rendered
  # }
# }