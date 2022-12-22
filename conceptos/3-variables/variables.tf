#REGEX 
variable "nombre_del_contenedor" {
    description         = "Indica el nombre del contenedor que vamos a crear"
    type                = string 
    nullable            = false
    validation  {
        condition       = length( regexall("^[a-zA-Z][a-zA-Z0-9.-_]{5,20}$", var.nombre_del_contenedor)) == 1
        # Funciones de terraform: https://developer.hashicorp.com/terraform/language/functions
        error_message   = "El nombre del contenedor no es válido"
    }
}


# Qué os parece esta solución? A MI UNA MIERDA GIGANTE !!!!!

variable "variables_de_entorno" {
    description         = "Variables de entornos para el contenedor que vamos a crear. Ojo, los valores deben rellenarse de la forma VARIABLE=VALOR"
    # Aquí hay un comportamiento MAGICO.... NO ES EXPLICITO 
    # POR DIOS,  SIEMPRE EXPLICITO !!!!!!!
    type                = map(string) 
    nullable            = true
}



variable "imagen_del_contenedor_repo" {
    description         = "Indica el repo de la imagen a usar por el contenedor que vamos a crear"
    type                = string 
    nullable            = false
}
variable "imagen_del_contenedor_tag" {
    description         = "Indica el tag de la imagen a usar por el contenedor que vamos a crear"
    type                = string 
    nullable            = false
}
variable "cuota_cpu" {
    description         = "Indica la cuota de cpu que puede usar el contenedor que vamos a crear"
    type                = number 
    #default     = 1024 ESTO NO LO HACEMOS NUNCA EN LOS SCRIPTS... NUNCA JAMAS!!!!
                # Y entonces, para que sirve esa propiedad default? 
                # YA lo veremos !
    # El valor null es un valor más, como otro cualquier, con un significado muy peculiar
    # Al definir una variable, puedo indicar si quiero que la variable admita el valor null
    nullable            = true #false... De hecho true es el valor por defecto
    validation  {
                         # Condicional
                         # CONDICION ? VALOR si la condicion es true : VALOR si la condicion es false
        condition       = var.cuota_cpu == null ? true : var.cuota_cpu > 0
                            # En las expresiones de validación de una variable NO PUEDO REFERIRME A OTRA VARIABLE!
                            # Una expresión que si devuelve true significa que el dato es bueno
        error_message   = "La cuota de cpu debe ser mayor que CERO"
                            # Mensaje que muestro al usuario si la expresion retorna false
    }
}

variable "puertos_a_exponer" {
    
    description = "Información de los peurtos a exponer del contenedor, incluyendo puerto externo, interno y opcionalmente la dirección ip."
    type = list(object({
                                interno = number
                                externo = number
                                ip      = optional(string, "0.0.0.0")
                        }))
    
    # Todas y cada una de las ip sean realmente IPs ~> regex
    
    validation {
        condition     = alltrue( [ for puerto in var.puertos_a_exponer: 
                                    length( regexall("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)$", puerto.ip)) == 1
                                 ] )
        error_message = "Las ips deben tener un formato correcto."

    }
    # Que Todos y cada uno de los puertos internos estén entre el 1 y el 32500
    validation {
        condition     = alltrue( [ for puerto in var.puertos_a_exponer: puerto.interno > 0 && puerto.interno <= 32500 ] )
        error_message = "Los puertos internos debe estar en el rango 0-32500"
    }
    # Que Todos y cada uno de los puertos externos estén entre el 1 y el 32500
    validation {
        condition     = alltrue( [ for puerto in var.puertos_a_exponer: puerto.externo > 0 && puerto.externo <= 32500 ] )
        
        # Round 1       puerto                          puerto.externo = 8080 > 0           true 
        #                {                                                                   &&
        #                    interno = 80               puerto.externo = 8080 <= 32500      true
        #                    externo = 8080                                                 ------> true
        #                    ip      = "127.0.0.1"
        #                }
        # Round 2       puerto                          puerto.externo = 8443 > 0           true 
        #                {                                                                   &&
        #                    interno = 443              puerto.externo = 8443 <= 32500      true
        #                    externo = 8443                                                 ------> true
        #                    ip      = "171.31.20.235"
        #                }
        # Despues del for, que tengo: [ true , true ]
        # alltrue( [ true , true ] ) -> true
        
        error_message = "Los puertos externos debe estar en el rango 0-32500"
    }
}

#puerto.externo > 0                  && puerto.externo <= 32500
#true                                &&    true                  true     

#llueve  truena      llueve y truena &&    llueve o truena ||
#true    true        true                    true
#true    false       false                   true
#false   true        false                   true
#false   false       false                   false