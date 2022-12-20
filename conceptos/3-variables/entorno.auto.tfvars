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