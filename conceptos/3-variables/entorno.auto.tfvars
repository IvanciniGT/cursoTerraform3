cuota_cpu = 2048
imagen_del_contenedor_repo = "nginx"
imagen_del_contenedor_tag = "latest"

#  DEBUG < true
#  Variable2 < valor2

#variables_de_entorno = [ "DEBUG=true", "Variable2=valor2" ]
#variables_de_entorno = [ "DEBUG << true", "Variable2 << valor2" ] 
#variables_de_entorno = [ "DEBUG|true", "Variable2;valor2" ] 
#variables_de_entorno = [ "DEBUG","true", "Variable2","valor2" ] 

variables_de_entorno =  {
                            DEBUG       = "true"
                            Variable2   = "valor2"
                        }
                        # [ "DEBUG=true", "Variable2=valor2" ]
nombre_del_contenedor = "micontenedor17"                        

# MIERDOLO DESCOMUNAL !!!!
#puertos_internos_a_exponer  = [80, 443]
#puertos_externos_a_exponer  = [8080, 8443]
#ips_a_exponer               = ["127.0.0.1", "172.31.20.235"]



# list(map(string))
puertos_a_exponer = [
                        {
                            interno = 80
                            externo = 8080
                            #ip      = "127.0.0.1"
                        },
                        {
                            interno = 443
                            externo = 8443
                            ip      = "172.31.20.235"
                        }
                    ]

