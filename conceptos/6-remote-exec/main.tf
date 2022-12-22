resource "docker_container" "micontenedor" {
    name = "remoto"
    image = docker_image.miimagen.image_id
    
    # Al trabajar con provisionadores remotos (y también con lo file)
    # necesitamos un bloque connection
    connection {
        type        =   "ssh"
        port        =   22
        host        =   self.network_data[0].ip_address
        user        =   "root"
        password    =   "root"
    }
    
    provisioner "remote-exec" {
        inline = [ "echo hola desde el contenedor" ,
                   "echo hola soy un fichero > /tmp/fichero.txt"]
        # equivalente a la propiedad command del provisioner local.exec
    }
    provisioner "remote-exec" {
        script = "./miscript.sh" # Fichero que tenga en local
        # scripts = ["","",""]
    }
    
    provisioner "file" { # Generamos un fichero dinamicamente
        destination = "/tmp/fichero1.generado"
        content     = "Yo soy el contenido del fichero: ${self.name}"
        # En este caso, usamos muy habitualmente la función `file`o la funcion
        # `templatefile`
    }
    provisioner "file" { # Copiar un archivo del local al remoto
        destination = "/tmp/fichero2.generado"
        source      = "./archivoParaCopiar.txt"
    }

}

resource "docker_image" "miimagen" {
    name = "rastasheep/ubuntu-sshd"
}
