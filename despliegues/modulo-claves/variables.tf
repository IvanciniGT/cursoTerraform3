variable "keys_path" {
    type        = string
    description = "Directorio donde se deben guardar las claves / de donde se deben leer las claves"
    default     = "./keys"
    nullable    = false
    
    # validacion: Que lo que me pasen sea una ruta válida http://federico, +34-91-789-98-09, ivan.osuna.ayuste@gmail.com
    # esas validación la haremos con REGEX
    # Empieza por:
    # /nombre
    # nombre
    # ./nombre
    # ../nombre/nombre/
    validation {
        condition       = length(regexall("^(([.]{0,2}\\/)?[a-zA-Z0-9._-]+(\\/[a-zA-Z0-9._-]+)*\\/?)$", var.keys_path)) ==1
        error_message   = "El directorio suministrado no es válido"
    }

}

variable "force_generate" {
    type        = bool
    description = "Indica si se deben regenerar las claves aún existiendo los ficheros de las mismas"
    default     = false # El comportamiento por defecto NUNCA puede ser DESTRUCTIVO
    nullable    = false
}

## Algoritmo y su configuración
### Validación? El algoritmo tendrá que ser uno de los admitidos
### Configuración tendrá validación.... evidentemente... en función del algoritmo suministrado

variable "algorithm" {
    type        = object({
                            name    = string
                            config  = optional(string, null)
                        })
    description = "Algoritmo a usar para la generación de las claves, junto a su configuración"
    nullable    = false
    default     = {
                      name    = "RSA"
                      config  = 2048
                  }
    validation {
        condition       = contains( ["RSA", "ECDSA", "ED25519"], var.algorithm.name )
        error_message   = "El algoritmo suministrado no es válido. Debe ser uno de esta lista: RSA, ECDSA o ED25519"
    }
    validation {
        condition       = var.algorithm.name != "RSA" ? true : ( can(tonumber(var.algorithm.config)) ? ( tonumber(var.algorithm.config) > 0 ) : false )
        error_message   = "Configuración no válida para el algoritmo RSA. Debe ser un número positivo."
    }
    validation {
        condition       = var.algorithm.name != "ECDSA" ? true : contains( ["P224", "P256", "P384", "P521"], var.algorithm.config )
        error_message   = "Configuración no válida para el algoritmo ECDSA. Debe ser un valor entre: P224, P256, P384, P521"
    }
    validation {
        condition       = var.algorithm.name != "ED25519" ? true : var.algorithm.config == null
        error_message   = "El algoritmo ED25519 no admite configuración, no la pongas !!!!!"
    }
}

# contains()
# tonumber()
# can()