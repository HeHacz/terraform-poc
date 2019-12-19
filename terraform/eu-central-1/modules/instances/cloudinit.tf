#cloudinit config
data "template_file" "salt-minion-install" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/init.cfg")
}

data "template_file" "volumes-mount" {
  template = file("./terraform/eu-central-1/modules/instances/scripts/volumes.sh")
    vars = {
    APP_DEVICE = var.APP_VOL_NAME
    LOG_DEVICE = var.LOG_VOL_NAME	
  }
}

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
}


data "template_cloudinit_config" "cloudinit-lb" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.salt-minion-install.rendered
  }
}
