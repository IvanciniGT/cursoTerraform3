variable "numero_de_contenedores" {
    description     = "Número de contenedores a crear"
    type            = number
    nullable        = false
    validation {
        condition       = var.numero_de_contenedores > 0 && var.numero_de_contenedores <= 20
        error_message   = "El numero de conteendores debe estar entre 1 y 20"
    }
}
# Qué os parece esta solución??? ^^^
# A mi me parece GUAY !
# Siempre y cuando nos sirva.. Es una solución simple y elegante.
# Pero con pocas opciones de personalización
variable contenedores_personalizados {
    description     = "Nombre y puerto a exponer de los contenedores personalizados a crear" 
    type            = map(number)
    nullable        = false
}
# Qué os parece esta solución??? ^^^
# A mi me parece GUAY !
# Siempre y cuando nos sirva.. Es una solución simple y totalmente funcional. CERO POR CIENTO AMBIGUA.
# Pero con pocas opciones de personalización... más que antes... pero aún así pocas
variable contenedores_mas_personalizados {
    description     = "Nombre y demás información de los contenedores a crear" 
    type            = map(object({
                                    interno = number
                                    externo = number
                                    ip      = optional(string,"0.0.0.0")
                                }))
    nullable        = false
}

variable contenedores_mas_personalizados_2 {
    description     = "Nombre y demás información de los contenedores a crear" 
    type            = list(object({
                                    nombre  = string
                                    interno = number
                                    externo = number
                                    ip      = optional(string,"0.0.0.0")
                                }))
    nullable        = false
}

