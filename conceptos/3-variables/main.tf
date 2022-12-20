resource "docker_container" "micontenedor" {
    name            = var.nombre_del_contenedor
    image           = docker_image.miimagen.image_id
    
    ##var.cuota_cpu
    #cpu_shares      = null 
                    # Al asignar a una propiedad el valor "null"
                    # Es como si no hubieramos definido la propiedad
                    # No se pasa al provider la propiedad 
    
    cpu_shares      = var.cuota_cpu
                    # Bucle en linea
    env             = [ for clave, valor in var.variables_de_entorno: "${clave}=${valor}" ]
    
    ports {
        internal    = 80   # http
        external    = 8080
        ip          = "127.0.0.1"
    }
    
    ports {
        internal    = 443   # https
        external    = 8443
        ip          = "172.31.20.235"
    }
}

resource "docker_image" "miimagen" {
        # Interporlacion de textos
    name = "${var.imagen_del_contenedor_repo}:${var.imagen_del_contenedor_tag}"
}
