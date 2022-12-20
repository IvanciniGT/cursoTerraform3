resource "docker_container" "micontenedor" {
    name            = "minginx"
    image           = docker_image.miimagen.image_id
    
    ##var.cuota_cpu
    #cpu_shares      = null 
                    # Al asignar a una propiedad el valor "null"
                    # Es como si no hubieramos definido la propiedad
                    # No se pasa al provider la propiedad 
    
    cpu_shares      = var.cuota_cpu
    
    env             = [ "DEBUG=true", "Variable2=valor2" ]
    
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
    name = "nginx:latest"
}
