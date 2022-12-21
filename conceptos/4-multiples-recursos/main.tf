terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {
}

resource "docker_container" "micontenedor" {
    name = "minginx"
    image = docker_image.miimagen.image_id
    ports {
        internal = 80
        external = 8080
    }
}
resource "docker_image" "miimagen" {
    name = "nginx:latest"
}
