Cluster producción
- Servidor nginx1 IP: 192.168.1.101
- Servidor nginx2 IP: 192.168.1.102
- Servidor nginx3 IP: 192.168.1.103
- Servidor nginx4 IP: 192.168.1.104
- Servidor nginx5 IP: 192.168.1.105


Balanceador de carga? SI
- Servidor 192.168.1.100 
    Cuando éste recibe una llamada, la reenvía a UNO de los 
    servidores de backend

Si en lugar de un cluster de producción, 
estuviera montando el entorno de desarrollo.
¿Cuántos servidores web montaría? 5? Con 1 sobra
Y en el entorno de desarrollo, montaré un balanceador de carga? Pa' qué? 

Todos ellos están sirviendo la misma web.

A esa web accederá un cliente desde su casa!
fqdn        -> 192.168.1.100
miapp.es (DNS)

---

# PROVISIONADORES - PROVISIONERS

Es una acción que se ejecutará al (CREAR/MODIFICAR) o (ELIMINAR) un recurso, de forma automática por terraform.

En terraform hay 3 Y SOLO 3 tipos de provisioners:
- local-exec        Nos permite ejecutar un comando en el entorno donde estamos corriendo terraform
    - ping, para probar conectividad
- remote-exec       Nos permite ejecutar un comando / script en el entorno remoto (el recurso que estamos creando/modificando/destruyendo)
                    para lo cuál lo primero que debe hacerse es conectar con el remoto (ssh/winrm)
    - Instalar las mínimas cosas requeridas por los de detrás. Python , agente de ?
- file              Nos permite copiar/crear un archivo en el entorno remoto (el recurso que estamos creando/modificando/destruyendo)


JENKINS 
    TERRAFORM
        -> Va a crear 1 maquina
    ANSIBLE
        -> Va a configurar esa máquina

        Puede ansible conectar con esa máquina? 
            Qué necesita ansible?
                Un inventario.... lo sabemos generar ya? SI... con la información de los OUTPUTS
                Usuario, Contraseña... credenciales
                Protocolo (ssh, winrm)
                playbook que ejecutar
                Necesito en esa máquina: PYTHON . Tengo python ? Y si no? Lo tendré que instalar... 
                Le puedo pedir a Ansible que instale python? no... es lo unico que necesita. JODIDO VOY
        Puede puppet para conectar con esa máquina? 
            Que la máquina tenga instalado el agente de puppet... lo tiene? Ni de coña !
            
Usos de los provisionadores... 
- Dejar la máquina / infra con el mínimo necesario para el siguiente en la cadena
- Hacer un smoke test: PRUEBA DE HUMO
    - ping
    - conectarme por ssh/winrm: echo EUREKA 