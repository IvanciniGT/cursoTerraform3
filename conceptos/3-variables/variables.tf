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