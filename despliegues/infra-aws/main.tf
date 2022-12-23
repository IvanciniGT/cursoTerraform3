resource "aws_instance" "mimaquina" {
    ami             = data.aws_ami.miami.image_id #"ami-00463ddd1036a8eb6" #### ESTO es ruina!
    instance_type   = "t2.micro"
    tags = {
        Name        = "maquina-de-${var.nombre_despliegue}"
    }
}

data "aws_ami" "miami" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# ID de la gente de Canonical (fabricantes de Ubuntu): 099720109477
# Arquitectura de microprocesador x64 amd64
# Virtualización: hvm
# Nombre de imagen: ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server