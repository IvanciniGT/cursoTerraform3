resource "docker_container" "micontenedor" {
    name            = var.nombre_del_contenedor
    image           = docker_image.miimagen.image_id
    
    ##var.cuota_cpu
    #cpu_shares      = null 
                    # Al asignar a una propiedad el valor "null"
                    # Es como si no hubieramos definido la propiedad
                    # No se pasa al provider la propiedad 
    
    cpu_shares      = var.cuota_cpu
                    # Bucle en linea me sirve para rellenar una propiedad
    env             = [ for clave, valor in var.variables_de_entorno: "${clave}=${valor}" ]
    
    # Bucle para componer bloques dinamicamente
    dynamic "ports" {
        for_each        = var.puertos_a_exponer # Aqui se pasa una lista
        iterator        = puerto # Nombre con el que me voy a referir a cada cosa de la lista
        content {
            internal    = puerto.value["interno"]
            external    = puerto.value["externo"]
            ip          = puerto.value["ip"]
        }
    }
    
}

resource "docker_image" "miimagen" {
        # Interporlacion de textos
    name = "${var.imagen_del_contenedor_repo}:${var.imagen_del_contenedor_tag}"
}
