resource "docker_container" "micontenedor" {
    name = "remoto"
    image = docker_image.miimagen.image_id
}

resource "docker_image" "miimagen" {
    name = "rastasheep/ubuntu-sshd"
}
