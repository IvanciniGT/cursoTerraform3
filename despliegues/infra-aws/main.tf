#locals {
#    ami_a_usar = length(data.aws_instance.mimaquina) == 1 && ! var.force_upgrade ? data.aws_instance.mimaquina[0].ami : data.aws_ami.miami
#}

resource "aws_instance" "mimaquina" {
    ami             = data.aws_ami.miami.image_id #"ami-00463ddd1036a8eb6" #### ESTO es ruina!   #local.ami_a_usar
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.miclave.key_name # NOMBRE de unas claves (solo la publica... openssh) registradas en amazon aws
                      # ESTO DE AQUI ^^^ VA A FUNCIONAR ???? 
                        # SI    I
                        # NO    
                        # NPI   IIIIII              < Ivan
                      # Podría funcionar o no... e Ivan no lo tiene claro. Ya que... de que depende que esto vaya a funcionar? 
                      # De qué recurso se haya ejecutado antes !
    tags = {
        Name        = "maquina-de-${var.nombre_despliegue}"
    }
    # depends_on = [ aws_key_pair.miclave ] # ESTO ES UNA MIERDA GIGANTE !!!! y de paso una MUY MUY MUY MUY MALA PRACTICA !
                                        # He de evitar totalmente usar esto. Y negaré haberoslo contado.
                                        # En muy muy muy pocos caso necesito hacer algo como esto
                                        # Y este no es un o de ellos.

    
    
}

resource "aws_key_pair" "miclave" {
  key_name   = "clave-publica-de-${var.nombre_despliegue}"
  public_key = module.misclaves.keys.publicKey.openssh # Meter la clave publica asociada a una clave privada mia en formato openssh
}

module "misclaves" {
    source = "../modulo-claves"
    
    keys_path = "./claves/"
    algorithm = {
        name = "RSA"
        config = "4096"
    }
    #force_generate = false
}
#data "aws_instance" "mimaquina" {
#  filter {
#    name   = "tag:Name"
#    values = ["maquina-de-${var.nombre_despliegue}"]
#  }
#}

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