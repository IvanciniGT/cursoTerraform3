numero_de_contenedores = 1

contenedores_personalizados = {
    produccion = 8443
    test       = 9999
    desarrollo = 9000
}

contenedores_mas_personalizados = {
    produccion = {
        interno = 80
        externo = 9888
        ip      = "127.0.0.1"
    },
    desarrollo = {
        interno = 80
        externo = 9890
        ip      = "172.31.20.235"
    }
}

contenedores_mas_personalizados_2 = [
    {
        nombre  = "nginx.produccion.es"
        interno = 80
        externo = 8555
        ip      = "127.0.0.1"
    },
    {
        nombre  = "nginx.desarrollo.es"
        interno = 80
        externo = 8565
        ip      = "172.31.20.235"
    }
] ## MAS EXPLICITA !