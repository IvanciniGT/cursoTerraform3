# Siempre lo voy a crear? NO
# Cuando lo montaré? Cuando numero_de_contenedores > 1
resource "docker_container" "mibalanceador" {

    #Si numero_de_contenedores > 1 , entonces 1
    # Y si no entonces 0

    count = var.numero_de_contenedores > 1 ? 1 : 0 # ACABAO !

    name    = "balanceador"
    image   = docker_image.miimagen.image_id
    ports {
        internal = 80
        external = 8079
    }
}

# Los count, además de permitirnos montar un BUCLE, para generar multiples recursos, también me permiten
# montar el quivalente a un IF, permitiendo crear o no un recurso de forma dinámica

# Al haber usado la palabra count dentro de un recurso:
# La variable docker_container.micontenedor devuelve/apunta a 
# una lista de recursos
resource "docker_container" "micontenedor" {

    count   = var.numero_de_contenedores # Aquí hay que suministrar un número
    # Cuando usamos en terraform la palabra COUNT, tenemos a nuestra
    # disposición la variable count.index, que va contando por cuál vamos
    # Esa variable empieza en el 0
    # Qué valores toma count.index 0,1, 2, 3, 4
    name    = "minginx_${ count.index + 1 }"
    image   = docker_image.miimagen.image_id
    ports {
        internal = 80
        external = 8080 + count.index
    }
}

# Al haber usado for_each, la variable docker_container.contenedores_personalizados
# nos devuelve / apunta a un MAPA de recursos, cuyas claves
# son las mismas que las del mapa suministrado en el for_each!
resource "docker_container" "contenedores_personalizados" {
    # Este for_each no tiene nada que ver con el de
    # los bloques dynamic
    for_each = var.contenedores_personalizados # Aquí tenemos que poner un MAPA!
                # No vale una lista, un MAPA !
    # Cuando usamos for_each, dentro de un resource, tenemos
    # a nuestra disposición la variable: each
    # A la que puedo pedir: each.key y el each.value
    name    = "minginx.${each.key}"
    image   = docker_image.miimagen.image_id
    ports {
        internal = 80
        external = each.value
    }
}

resource "docker_container" "contenedores_mas_personalizados" {
    for_each    = var.contenedores_mas_personalizados 
    # each ->   each.key        produccion, desarrollo
    #           each.value      objeto 
    #                                {
    #                                    interno = 80
    #                                    externo = 9888
    #                                    ip      = "127.0.0.1"
    #                                }
    name        = "elnginx.${each.key}"
    image       = docker_image.miimagen.image_id
    ports {
        ip       = each.value.ip
        internal = each.value.interno
        external = each.value.externo
    }
}

resource "docker_container" "contenedores_mas_personalizados_2" {
    count       = length(var.contenedores_mas_personalizados_2)
    # que variable tengo, por haber usado count ??? count.index
    # Que tomará los calores: 0 , 1
    
    name        = var.contenedores_mas_personalizados_2[count.index].nombre
    image       = docker_image.miimagen.image_id
    ports {
        ip       = var.contenedores_mas_personalizados_2[count.index].ip
        internal = var.contenedores_mas_personalizados_2[count.index].interno
        external = var.contenedores_mas_personalizados_2[count.index].externo
    }
}

resource "docker_image" "miimagen" {
    name    = "nginx:latest"
}
