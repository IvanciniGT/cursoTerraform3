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
                            # Una expresión que si devuelve true significa que el dato es bueno
        error_message   = "La cuota de cpu debe ser mayor que CERO"
                            # Mensaje que muestro al usuario si la expresion retorna false
    }
}