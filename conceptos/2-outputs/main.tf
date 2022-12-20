resource "docker_container" "micontenedor" {
    name            = "minginx"
    image           = docker_image.miimagen.image_id
    
    cpu_shares      = 1024
    
    env             = [ "Variable1=valor1", "Variable2=valor2" ]
    
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
