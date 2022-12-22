# Este fichero es un script para 
# Montar un contenedor de nginx y apache. PUNTO PELOTA

module "apache" {
    source = "../7-modulo"
                #https://developer.hashicorp.com/terraform/language/modules/sources
    nombre_del_contenedor = "servidor.apache"                        

    imagen_del_contenedor_repo = "httpd"
    imagen_del_contenedor_tag = "latest"
    
    variables_de_entorno = var.env_apache
    puertos_a_exponer = [
                        {
                            interno = 80
                            externo = var.puerto_para_exponer_apache
                        }
                    ]
}

module "balanceador" {
    source = "../7-modulo"
    
    nombre_del_contenedor = "servidor.nginx"                        

    imagen_del_contenedor_repo = "nginx"
    imagen_del_contenedor_tag = "latest"

    variables_de_entorno = var.env_nginx
}
