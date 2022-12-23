locals {

    ruta_carperta_de_los_ficheros_de_las_claves     = endswith( var.keys_path , "/" ) ? var.keys_path : "${var.keys_path}/"

    fichero_clave_privada_formato_pem               = "${local.ruta_carperta_de_los_ficheros_de_las_claves}privatekey.pem"
    fichero_clave_privada_formato_openssh           = "${local.ruta_carperta_de_los_ficheros_de_las_claves}privatekey.openssh"
    fichero_clave_publica_formato_pem               = "${local.ruta_carperta_de_los_ficheros_de_las_claves}publickey.pem"
    fichero_clave_publica_formato_openssh           = "${local.ruta_carperta_de_los_ficheros_de_las_claves}publickey.openssh"

    existe_el_fichero_clave_privada_formato_pem     = fileexists( local.fichero_clave_privada_formato_pem     )
    existe_el_fichero_clave_privada_formato_openssh = fileexists( local.fichero_clave_privada_formato_openssh )
    existe_el_fichero_clave_publica_formato_pem     = fileexists( local.fichero_clave_publica_formato_pem     )
    existe_el_fichero_clave_publica_formato_openssh = fileexists( local.fichero_clave_publica_formato_openssh )

    existen_ficheros_claves = ( local.existe_el_fichero_clave_privada_formato_pem       &&
                                local.existe_el_fichero_clave_privada_formato_openssh   && 
                                local.existe_el_fichero_clave_publica_formato_pem       &&
                                local.existe_el_fichero_clave_publica_formato_openssh )
}

resource "tls_private_key" "claves" { # Este tipo de recurso genera nuevas claves publica/privada y las exporta a lo que quiera
    # Cuantos queremos que se generen al ejecutar el script? 1 siempre? Nooo ... y si existen ficheros con claves? 0
    count       = local.existen_ficheros_claves          && !     var.force_generate  ?   0                      : 1
                  # Si existen los ficehros de las claves y no me piden que los regenere, no creo nuevas claves, en caso contrario si las creo
    
    algorithm   = var.algorithm.name
    ecdsa_curve = var.algorithm.name == "ECDSA" ? var.algorithm.config : null
    rsa_bits    = var.algorithm.name == "RSA"   ? var.algorithm.config : null
    
    provisioner "local-exec" {
        command = <<EOT
                       mkdir -p ${local.ruta_carperta_de_los_ficheros_de_las_claves} 
                       echo "${self.private_key_pem}" > ${local.fichero_clave_privada_formato_pem}
                       echo "${self.private_key_openssh}"     > ${local.fichero_clave_privada_formato_openssh}
                       echo "${self.public_key_pem}"  > ${local.fichero_clave_publica_formato_pem}
                       echo "${self.public_key_openssh}"      > ${local.fichero_clave_publica_formato_openssh}
                    EOT
    }
}
