variable "env_nginx" {
    type = map(string)
    description = "Variables de entorno para nginx"
}
variable "puerto_para_exponer_apache" {
    type = number
    description = "Puerto donde exponer apache"
}
variable "env_apache" {
    type = map(string)
    description = "Variables de entorno para apache"
}