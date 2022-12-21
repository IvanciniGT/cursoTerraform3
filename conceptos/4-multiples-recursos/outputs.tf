output "direcciones_ip" {
    value = [ for contenedor in docker_container.micontenedor: 
                contenedor.network_data[0].ip_address ]
}

output "direcciones_ip_personalizados" {
    value = [ for valor in docker_container.contenedores_personalizados: 
                valor.network_data[0].ip_address ]
}
output "direcciones_ip_personalizados_2" {
    value = [ for clave, valor in docker_container.contenedores_personalizados: 
                "${clave}=${valor.network_data[0].ip_address}" ]
}