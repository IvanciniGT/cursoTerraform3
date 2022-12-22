# Desde este output debo poder acceder a la clave privada / publica en formato pem y openssh
# tanto si se ha generado un par de claves nuevo como si lo hemos leido de un fichero
output "keys" {
    value = length(tls_private_key.claves) == 0 ?  {    # Aqui relleno los datos del fichero, ya que no hay recurso
                                                        privateKey = {
                                                                        pem     = file(local.fichero_clave_privada_formato_pem)
                                                                        openssh = file(local.fichero_clave_privada_formato_openssh)
                                                                     }
                                                        publicKey  = {
                                                                        pem     = file(local.fichero_clave_publica_formato_pem)
                                                                        openssh = file(local.fichero_clave_publica_formato_openssh)
                                                                     }
                                                    } : { # Aqui relleno los datos del recurso, no me hace falta leer los ficheros
                                                        privateKey = {
                                                                        pem     = tls_private_key.claves[0].private_key_pem
                                                                        openssh = tls_private_key.claves[0].private_key_openssh
                                                                     }
                                                        publicKey  = {
                                                                        pem     = tls_private_key.claves[0].public_key_pem
                                                                        openssh = tls_private_key.claves[0].public_key_openssh
                                                                     }
                                                    }
    sensitive   = true
}