data "template_file" "salt-minion-install" {
  template = file("scripts/init.cfg")
}

data "template_file" "volumes-mount" {
  template = file("scripts/volumes.sh")
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
    content      = data.template_file.init-script.rendered
  }
  
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}


data "template_cloudinit_config" "cloudinit-lb" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }
}
