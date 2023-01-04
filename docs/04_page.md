# 04: Provisioners
Provisioners can be used to model specific actions on local or remote machine in order to prepare server or other infrastructure objects for service.

> Provisioners are a Last Resort


### file
Copies files or directoris from machine running terraform to the newly created resource

```code
resource "aws_instance" "webserver" {
    . . .
    
    provisioner "file" {
        source      = "./images"
        destination = "/var/www/html/images
    }

    provisioner "file" {
        content     = "ami used: ${self.ami}"
        destination = "/tmp/deployment.log" 
    }
}


resource "aws_instance" "webserver" {
    . . .

    connection {
        type     = "ssh"
        user     = "root"
        password = ""
        host     = "${self.public_ip}"
        private_key = file("${path.modeul}/ec2-key.pem")
    }

    provisioner "file" {
        source      = "conf/config.d"
        destination = "/etc"
    }
}

```

### remote-exec
Runs action on remote machine
```code
resource "aws_instance" "webserver" {
    . . .
    connection {
        type = "ssh"
        user = "root"
        password = ""
        host = "${self.public_ip}"
        private_key = file("${path.module}/ec2-key.pem")
    }

    provisioner "file" {
        source = "${file.path}/ec2-key.pem"
        destination = "/tmp/private-host-key.pem"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod 400 /tmp/private-host-key.pem"
        ]
    }
}
```

### local-exec
resource "aws_instance" "webserver" {
    . . .

    provisioner "local-exec" {
        command = "echo Created on `date` >> webserver_deployment.log"
        working_dir = "./"
        interpreter = ["/bin/bash", "-c"]
        on_failure = continue # contnue | fail(default)
    }

    provisioner "local-exec" {
        command = "echo destroyed on `date` >> webserver_deployment.log"
        working_dir = "./"
        # execute when destroy time
        when = destroy
    }
}