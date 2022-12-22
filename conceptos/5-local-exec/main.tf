resource "docker_container" "micontenedor" {

    count   = 10
    name    = "servidorweb_${ count.index + 1 }"
    image   = docker_image.miimagen.image_id

    provisioner "local-exec" {
        # Pruebas unitarias: Quiero probar una cosa, aislada del resto
        # Conectividad en red
        command = "sleep 1 && ping -c 1 ${self.network_data[0].ip_address}"
        # on_failure = continue     # En caso de error, no cortar el script, que sería el comportamiento por defecto
                                
    }

    provisioner "local-exec" {
        command = "curl -s --output /dev/null ${self.network_data[0].ip_address}"       # Servicio
        # when = destroy    # Podeis controlar que en lugar de ejecutarse cuando el recurso es 
                            # creado o modificado, se ejecute cuando es destruido
    }

}
locals {
    # Realmente aquí no hay una variable.
    # Es una expresión a la que me puedo referir con un nombre
    ips_de_los_contenedores = join("\n", [ for contenedor in docker_container.micontenedor: contenedor.network_data[0].ip_address ] )
}
# Nos permite ejecutar provisionadores según nos convenga (lo que definamos en el trigger)
resource "null_resource" "generar_fichero_inventario" {
    triggers = {
        aqui_pongo_trigo_por_no_poner_rodrigo = local.ips_de_los_contenedores
    }
    provisioner "local-exec" {
        command = "echo \"$IPS\" > inventario.ini"
        interpreter = ["/bin/bash" , "-c"] # python, perl, powershell cmd
        environment = {
            IPS = local.ips_de_los_contenedores
        }
    }
}

resource "docker_image" "miimagen" {
    name    = "nginx:latest"
}
