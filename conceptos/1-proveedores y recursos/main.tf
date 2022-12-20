# Este archivo es el que vamos a escribir con sintaxis HCL

# En sintaxis HCL podemos usar comentarios.

# OBJETIVO DEL SCRIPT: 
# Definir un contenedor con nginx, que posterirmente sea creado/eliminado/modificado por DOCKER

## BLOQUE terraform
# Nos permite especificar la versión de terraform
# Y definir los proveedores que usaremos
terraform {
    required_providers { # proveedores requeridos
        docker = {
            source = "kreuzwerker/docker" # Se buscará a través de su nombre en el terraform registry
        }
    }
}

# Aquí ponemos la configuración del proveedor
provider "docker" {
  # En el caso de docker, no es requerida a priori ninguna configuración
}

#resource "TIPO_DE_RECURSO" "NOMBRE_INTERNO" { ... }

resource "docker_container" "micontenedor" {
    # Configuración de ese recurso concreto
    # nombre_de_contenedor -> minginx
    name = "minginx"
    # imagen_del_contenedor -> nginx:latest
    # image = "nginx:latest" no vale... aqui debemos poner el
    # ID y no el NOMBRE
    image = docker_image.miimagen.image_id
}

# Al crear un recurso, tenemos a nuestra disposición dentro del script la variable: TIPO_RECURSO.NOMBRE
# En nuestro caso: docker_image.miimagen
# Esa variable devuelve (apunta) a un recurso del tipo suministrado, al que podemos consultarle sus propiedades
resource "docker_image" "miimagen" {
    # nombre_imagen_del_contenedor -> nginx:latest
    name = "nginx:latest"
}

## Terraform no es tan imbecil. 
# En automático genera un arbol de dependencias entre recursos.
# Es en base a ese árbol que va a ejecutar los recursos.
# NO LO HACE EN BASE AL ORDEN QUE YO ESCRIBA

