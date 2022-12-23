Nos queremos crear una máquina en AWS.

# VARIABLES

- qué características de hardware?
- qué sistema operativo LINUX?
- la red?
- puertos que quiero abrir

# RESOURCES
Generar credenciales
Esa máquina tendrá unas determinadas características de hardware
En esa máquina montaremos un determinado Sistema Operativo LINUX
Esa máquina la enchufaremos a una red
Configurar unas reglas de firewall
Alguna prueba para evr si queda bien creada y si tengo conectividad:
- ping
- Probar el puerto 22
- Conectarme por ssh < credenciales

# OUTPUTS 

Necesitaremos sacar la IP

# PROVIDER 

aws? es el provider? NO. 
donde crearé en última instancia los recursos? AWS

El provider qué es? AWS? NO
Qué era un provider? Un programa que tengo que instalar en MI MAQUINA que permite a terraform dar órdenes / interactuar con AWS

    script terraform  --->  terraform  -->  provider         --> AWS cli        ---> AWS
    defino recursos                         init: descargar      ^^ credenciales
                                            apply