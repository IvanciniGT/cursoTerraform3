# Terraform

Es una herramienta de software creada por HashiCorp (Vagrant), que nos ofrece:
- Un lenguaje DECLARATIVO, llamado HCL (HashiCorp Language)
- Un intérprete de linea de comandos, que nos permite ejecutar comandos sobre los scripts que vamos a crear con ese lenguaje

## Uso:

Para gestionar (adquirir/liberar/mantener/modificar) RECURSOS que contratamos/adquirimos en un PROVEEDOR.

| Recursos                          | Proveedores                           |
| --------------------------------- | ------------------------------------- |
| Disco, tarjeta de red, máquina    | Cloud: AZURE, AWS, IBM...             |
| BBDD MariaDB                      | AWS                                   |
| Entrada DNS                       | Servidor DNS                          |
| Usuario                           | Identity provider (Active directory)  |
| Par de claves ssh                 | ?                                     |

# Cloud?

Conjunto de servicios (relacionados con el mundo de las tecnologías de la información) que una empresa ofrece a través de internet:
- Pago por uso
- Esos servicios se ofrecen de forma desatendida / automatizada / sin mediación humana

Clouds más importantes:
- AWS: Cloud de Amazon
- AZURE: Cloud de Microsoft
- GCP: Cloud de Google

Los servicios que se ofrecen en un cloud los solemos clasificar en 3 tipos:
- IaaS: Servicios de infraestructura (máquinas, disco, redes, ...)
- PaaS: Servicios de plataforma (bbdd, identity provider, dns, cluster de kubernetes)
- SaaS: Servicios de software (cloud9)

## Los clouds.. a día de hoy... son importantes? Ya ves que lo son 

### Entornos de producción

- Alta disponibilidad 
  
  "Intentar" garantizar un determinado tiempo de servicio, pactado contractualmente.
    90% = RUINA !     = 36,5 días/año un sistema OFFLINE                                |   €
    99% = MALAMENTE ! = 3,65 días/año un sistema OFFLINE = PELUQUERIA DE LA ESQUINA !   |   €€
    99,9% = MINIMO    = 8 horas/año = BANCO                                             |   €€€€€€
    99,99% = minutos: 20 minutos al año = HOSPITAL                                      v   €€€€€€€€€€€€€€€€€
  "Intentar" garantizar la NO PERDIDA de información. x3 (RAID5)

    REDUNDANCIA

- Escalabilidad

  Capacidad de ajustar la infraestructura a las necesidades de cada momento.
  
  App3: Internet
  Horas n    : 100 usuarios                             Escalabilidad vertical:   MAS MAQUINA !
  Horas n+1  : 1000000 usuarios    BlackFriday          Escalabilidad horizontal: MAS MAQUINAS !
  Dia n+2    : 1000 usuarios
  Dia n+3    : 2000000 usuarios    CiberMonday

Lo que necesitamos es montar un programa que gestione automáticamente la infraestructura o la gestión de unos recursos en un cloud... (u otro tipo de proveedor). Qué tipo de programa es éste? SCRIPT (guión)

Para automatizar la adquisición de recursos en un cloud, los clouds ofrecen distintas opciones:
- AWS cli
- AZURE cli

Entonces... qué pinta Terraform? Por qué usamos Terraform para montar esos scripts?
- Interacciona con todos.
- Los clouds no son intercambiables... script terraform -> AWS o a AZURE? Ni de coña!

# Lenguaje declarativo

Todas las herramientas que hoy en día lo PETAN, es porque usan lenguajes declarativos:
- ANSIBLE, PUPPET, CHEF, SALT --> Aprovisionadores          BASH, SH, PS1, BAT, PYTHON -> Lenguaje imperativo!
- KUBERNETES, OPENSHIFT
- TERRAFORM, VAGRANT

Adoramos los lenguajes declarativos. ODIAMOS los lenguajes imperativos!

## Uso imperativo de un lenguaje frente a un uso declarativo

### Español

- La silla está debajo de la ventana            Enunciativa afirmativa
- La silla NO está debajo de la ventana         Enunciativa negativa
- Está la silla debajo de la ventana?           Interrogativa
- Pon la silla debajo de la ventana             Imperativa          Expresa una orden 
- Quiero la silla debajo de la ventaja          Desiderativa        Expresa un deseo
- Debe haber una silla debajo de la ventana     Declarativo

# Ejemplo de uso imperativo de un lenguaje... y sus problemas

    IF hay algo debajo de la ventana:
        Felipe, quitalo!!!
    IF no hay silla:
        Felipe, vete al IKEA a comprar una silla
    Felipe, pon la silla debajo de la ventana.                  Digo lo que tiene que hacer

# Ejemplo de uso declarativo de un lenguaje... y sus ventajas

    Felipe, debe haber una silla debajo de la ventana!          Digo lo que quiero/necesito
                                                                Defino el estado en que quiero que 
                                                                quede la casa

## En los lenguajes declarativos, se produce un fenómeno que llamamos idempotencia:

>   Da igual el estado del que yo parta, el sistema siempre queda de la misma forma.

---

# Script de terraform 

Define un conjunto de recursos asociados a un proveedor:

- Servidor con 8 cpus y 16 Gbs de Ram x 4
- Balanceador de carga por delante de los servidores
- Red que trabaje en 192.168.0.0/16
- Los servidores en esa red 

SCRIPT TF ---> terraform VERBO 
                         apply
                         destroy

Acabo con un programa (script) que solo da un listado de recursos... catalogo
Script TF = catalogo de recursos -> Voy a tratar la INFRAESTRUCTURA COMO si fuera un CODIGO de programación

Cuándo escribimos un código de programación de un programa: REPOSITORIO DE UN SCM (git)
Y vamos teniendo VERSIONES de ese código.

Y la infraestructura la voy a tratar de esa misma forma:
- Voy a tener la infra definida en un fichero
- Ese fichero en un sistema de control de versión
- Y ese fichero irá teniendo distintas versiones.

# DEV-->OPS

Filosofía, moviento, una cultura en pro de AUTOMATIZACION

                AUTOMATIZABLE       HERRAMIENTAS                                QUIEN?
    PLAN                x
    CODE                x
    BUILD               √           maven gradle nuget dotnet poetry            Desarrollo
    TEST                
        diseño          x
        ejecución       √           selenium jmeter sonarqueb appium soapui     Tester
                                    postman loadrunner cucumber karate
        Se hacen en un entorno de: 
            pruebas, test, previo, preproducción, integración
            El entorno de integración lo creo de USAR Y TIRAR !
                        √           TERRAFORM, Ansible, Docker, kubernetes      Administrador de sistemas
    Generar un distribuible     
                        √           Imagen de contenedor (Dockerfile)
    Despliegue de la app en producción
                        √           Terraform, Vagrant
                                    Ansible, Puppet
    Operarla
        Si se cae el servidor en producción: Reiniciarlo
        Si me quedo sin capacidad de procesamiento: Escalar 
            Más servidores          Terraform
    
* Todas estas tareas son lanzadas/orquestadas por un SERVIDOR DE AUTOMATIZACION: 
    Jenkins, Github actions, Gitlab CI/CD, Azure devops (TFS), Bamboo,          DEVOPS
    Team city, travisCI


# Scripts de terraform


Es un directorio, que tiene dentro al menos 1 fichero con extensión .tf... 
y con nombre: el que me dé la real gana!
Existen convenios... tradicionalmente encontramos ficheros con los nombres:
- main.tf
- outputs.tf
- variables.tf
- versions.tf

En esos archivos, escribimos bloques de código en sintaxis HCL.
Y tenemos unos pocos tipos de bloques que podemos usar:
- terraform         Nos permite especificar la versión de terraform             LUNES
                    y definir los proveedores que usaremos              
- provider          Dar la configuración de un proveedor                        LUNES
- resource          Definir un recursos que quiero gestionar a través           LUNES
                    de un proveedor
    provisioners                                                                JUEVES
- output            Obtener información de vuelta del recurso                   LUNES/MARTES
- variable          PARAMETRIZAR los scripts                                    MARTES/MIERCOLES
                    ** NOTA: Con mucha diferencia es lo más complejo de terraform
                             Y lo más importante
- locals            Nos permite definir otro tipo de "variables"...             MIERCOLES/JUEVES
                    de uso interno
- module                                                                        JUEVES
------ AQUÍ EMPEZAREMOS A TRABAJAR CON UN CLOUD
- data                                                                          VIERNES < CLOUD

Una vez creado un script de terraform, se lo pasaremos al comando "terraform", y a ese comando
le podremos pedir la aplicación de un verbo sobre el script:
- init          Identifica el directorio como script de terraform
                Descargará los proveedores necesarios para el script
                Descargará los modulos necesarios para el script
                ... y algo más descargará (que ya os enterareis)
- validate      Comproeba (valida) la sintaxis del script
- plan          Compara el estado actual del entorno con el deseado
                para establecer un plan de ejecución que concluya con 
                el entorno en el estado deseado
- apply         Aplica un plan de ejecución:
                    - Creando     \
                    - Modificando  > recursos
                    - Eliminando  /
- destroy       Desmantelar la infraestructura: Eliminar todos los recursos
- ....

Tenemos una situación que resolver.. o mejor dicho, que establecer !

Nuestros recursos van a ser:
- Contenedores de docker
- Imagenes de contenedor

El proveedor va a ser Docker.

nginx
httpd
---

# Contenedor ?

Es un entorno aislado dentro de un SO con kernel Linux donde ejecutar procesoS.

Aislado?
- Tiene su propia configuración de red -> Un contenedor tiene su propia IP
- Tiene sus propio sistema de archivos
- Tiene sus propias variables de entorno
- Puede tener limitación de acceso a los recursos del hardware

Los contenedores los creamos desde una IMAGEN DE CONTENEDOR

# Imagen de contenedor?

Es un triste archivo comprimido (tar) que lleva dentro un programa YA INSTALADO y configurado por alguien...
que sabe un huevo más que yo de ese programa (habitualmente su desarrollador)


## Imaginad que quiero instalar SQL Server
1º Descargo un instalador
2º Ejecuto ese instalador... y aquello puede requierir que tenga conocimientos avanzados de ese software que quiero instalar. 
3º Arranco SQL Server

c:\archivos de programa\SQLServer -> ZIP ---> email -> funciona? NI DE COÑA !
                                      v
                                      Imagen de contenedor



# Métodos de instalación de software

## Método tradicional

        App1 + App2 + App3          Problemas? 
    ----------------------------        - Incompatibilidad en las dependencias / configuraciones
        Sistema operativo:              - Seguridad
     Windows, GNU/Linux, MacOS          - App1 (BUG: 100% CPU)  APP1 -> OFFLINE
    ----------------------------                                APP2 y APP3 van detrás !
              HIERRO

## Método basado en Máquinas Virtuales

        App1    |  App2 + App3      Problemas?
    ----------------------------        - Incremento en la complejidad de la instalación/mantenimiento
        SO 1    |     SO 2              - Desperdicio de recursos
    ----------------------------        - Empeoramiento en el rendimiento de las apps 
        MV 1    |     MV 2
      2 cores   |    1 core
      8 Gbs     |    4 Gbs
    ----------------------------    
     Hipervisor: Vmware, citrix
      hyperv, kvm, virtualbox
    ----------------------------    
        Sistema operativo:          
     Windows, GNU/Linux, MacOS      
    ----------------------------    
              HIERRO
        16 Gbs + 8 cores

## Método basado en Contenedores

        App1    |  App2 + App3     
    ----------------------------   
        C 1     |     C 2
      2 cores   |    1 core
      8 Gbs     |    4 Gbs
    ----------------------------    
     Gestor de contenedores:
     Dockerd, containerd, podman
     crio
    ----------------------------    
        Sistema operativo:          
        con kernel Linux      
    ----------------------------    
              HIERRO
        16 Gbs + 8 cores

## Resumen contenedores

- Un conteneedor hace las veces (para algunas cosas) de una máquina virtual
- Se crean desde una imagen de contenedor
- Que previamente he necesitado descargar
- Al contendor le puedo asignar sus propias variables de entorno
- El contenedor tiene su propia IP, donde abro sus puertos...
- Esos puertos los puedo exponer en una de las IPs del host, en el mismo puerto... o en otro.

En inglés el imperativo se forma con la forma del Infinitivo sin el "to"
To create -> create
To be -> be.... Be happy my friend !

---

# Qué es para terraform un provider?

El cliente / tecnología contra la que trabajo. AWS, IBM Cloud? NO

Para terraform, un provider es un PROGRAMA ADICIONAL que le permite a terraform hablar (gestionar recursos)
en un proveedor de servicios externo a terraform.

    script de terraform ---> terraform --->  HASHICORP/AWS ---->  aws cli ---> AWS (Cloud de amazon)
    1 servidor con unas                         ^                                servidor
        características                      provider

Esos provider los encontramos en lo que llamamos el TERRAFORM REGISTRY

## Tipos de datos en terraform:

- number        Números
                3 8 1024

- string        Cadenas de texto
                "hola"

- boolean       Valores lógicos: 
                > true false

- list(xxx)     Una lista de valores. Donde podemos acceder a cada valor a través de su posición.
                > list(string) list(number)
                > [1,2,3] ["hola","adios"] [true, true, false]

- set(xxx)      Una lista de valores también, donde no podemos acceder a cada valor a través 
                de su posición.
                Solo puedo iterar sobre los valores. Dame el siguiente!
                > set(string) set(number)
                > [true, true, false]

- map(x)       Un conjunto clave-valor.
               Para terraform, las claves de un map siempre son strings.
               > map(string) # Los valores serán string.. Aquí no digo nada de las claves
                { 
                    "nombre" = "Ivan"
                    "apellidos" = "Osuna Ayuste"
                }

- object(...)

Pero... hay un tipo adicional que aplica solo a las propiedades de alguinos recursos(resource)

Es el tipo BLOCK.... que normalmente aparece como block list | block set
Con estos me echo a temblar ! No mucho.. solo un poquito... Son un caso especial dentro de las propiedaes
Llevan una sintaxis DIFERENTE al resto.

Cualquier propiedad, la defino como:
NOMBRE_PROPIEDAD = VALOR

Salvo las propiedades de tipo BLOCK:
NOMBRE_PROPIEDAD_BLOCK {
    ... Y aquí dentro más propiedades... que obedecerán a un esquema anidado
}



