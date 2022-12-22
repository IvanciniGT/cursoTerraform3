module "nginx" {
    source = "../7-modulo"
    
    cuota_cpu = 2048
    imagen_del_contenedor_repo = "nginx"
    imagen_del_contenedor_tag = "latest"
    
    variables_de_entorno =  {
                                DEBUG       = "true"
                                Variable2   = "valor2"
                            }
    
    nombre_del_contenedor = "micontenedor17"                        
    
    puertos_a_exponer = [
                            {
                                interno = 80
                                externo = 8080
                            },
                            {
                                interno = 443
                                externo = 8443
                                ip      = "172.31.20.235"
                            }
                        ]
}