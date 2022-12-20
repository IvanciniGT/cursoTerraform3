
output "direccion_ip" {
#    value = docker_container.micontenedor.ip_address
    value = docker_container.micontenedor.network_data[0].ip_address
}

# La puedo sacar a posteriori de forma sencilla:
# $ terraform output
# $ terraform output direccion_ip -> Esto devuelve formato HCL
# 
# Lo puedo pedir alternativamente en JSON o texto plano
# $ terraform output [--json|--raw] direccion_ip
