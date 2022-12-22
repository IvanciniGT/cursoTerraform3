output "direccion_apache" {
    value = module.apache.direccion_ip
}
output "direccion_balanceador" {
    value = module.balanceador.direccion_ip
}