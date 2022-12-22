variable "keys_path" {
    type        = string
    description = "Directorio donde se deben guardar las claves / de donde se deben leer las claves"
    default     = "./keys"
    nullable    = false
    
    # validacion: Que lo que me pasen sea una ruta válida http://federico, +34-91-789-98-09, ivan.osuna.ayuste@gmail.com
    # esas validación la haremos con REGEX
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