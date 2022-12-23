# Estado de la infraestructura

## Script 

Definimos un catalogo de recursos que va pasando por distintas versiones, que irán asociadas en algunos casos 
a versiones del sistema que quiera instalar:

- Cambio en un provider, que puede requerir que yo cambie mi script:
    - para establecer lo mismo de antes, pero usando otras propiedades
    - para recuperar un output de distinta forma
- Un cambio en la imagen del contenedor/imagen con la que voy a plataformar una máquina
    > Ubuntu 20.04 ed. Junio de 2021
    > Ubuntu 20.04 ed. Agosto de 2021
    ** Nota: Habiendo hecho esto bien... el propio script, ya debería elegir la versión la reciente de ubuntu.
    Parametrización 
- Cambios en reglas de firewall
  > Monto un servidor para instalar ElasticSearch. Quién monta ES? Ansible, Puppet,...a mano
  > Elasticsearch trabaja en los puertos 9200 y 9300 . Parametrización 
  > A mi me toca abrir esos puertos en el firewall de la máquina ... quién hace eso? Ansible
  > A mi me toca abrir esos puertos en un firewall de red (AWS, IBM Cloud)... quién hace eso? Terraform
  > Podría ser que yo necesite a futuro abrir otros puertos? Raro.. podría ser... pero yo lo veo raro.
  > La máquina la monto para ElasticSearch > 9200 y 9300. 
- Añadir nuevos recursos:
    - Disco con más capacidad ? Parametrización 
    - Monto MARIADB/MYSQL para una app que acabamos de comenzar a usar en producción, dentro de algo más complejo
        - Monto 2 máquinas para alojar esa BBDD (Activo/Pasivo) -> Terraform : 3306
        - Quizás al año, por el uso que va teniendo el sistema, decido (a nivel de negocio, de desarrollo, de app)
          que esa BBDD debe operar en cluster
            - Necesito más máquinas
            - Necesito nuevas reglas de firewall : 3306 y con el puerto que usan las máquinas de MariaDB para comunicarse entre si
        NO ES PARAMETRIZACION
    - Estamos montando unos microservicios: Microservicio 1 y el 2. Versión 1 de la aplicación
        - Necesito máquinas para montar ambos microservicios
        - Al año se decide a nivel de diseño de la aplciación que esos microservicios los voy a comunicar 
          a traves de un Kafka / RabbitMQ ( sistemas de mensajería basados en colas): Versión 2 de la aplicación
            - Necesitar otras máquinas, de otro tipo, con otra configuración
        NO ES PARAMETRIZACION

Vamos a acabar con un script:
    - Recursos
    - Parametrización (Variables)
        - Parametros que OJITO CON ELLOS ! Su cambio implica un cambio profundo, grande, que quiero controlar muy bien.
            - Que versión de SO monto
            - Que puerto operan
            - Que capacidad de disco le doy a una máquina
            DE ALGUNA FORMA QUIER TENER CONTROLADOS (MUY CONTROLADOS) esos cambios
        - Parametros que cambian a cada rato, sin un impacto grande en el sistema
            - Número de máquinas que monto para un cluster de servidores web: Apaches? Las que necesitemos cada hora 
              ^^^^ Son las que más me obligan a usar algo como terraform (AUTOMATIZADO)
            ME IMPORTA UIN PEPINO CONTROLAR ESOS CAMBIOS... se harán cuando se requiera... y punto
    - Outputs
    + Proveedor

Imaginad que soy una empresa que monta un software para la gestión de unos hospitales, universidades, empresas...
Y le ofrezco el software mediante un modelo SaaS: Ofrecido como un servicio de software (esta es la tendencia)

    Script de despliegue de infraestructura (Terraform) que albergue mi SOFTWARE de gestión de hospitales -> git repo 1

    Me llega un cliente 1: Hospital XXX (Pequeño) : Quiero tu software:
        Fichero de variables para el hospital XXX                                                         -> git repo 2

    Me llega un cliente 2: Hospital YYY (Mediano) : Quiero tu software:
        Fichero de variables para el hospital YYY                                                         -> git repo 3

    Para el hospital XXX, cuando aplique la infra cojo: 
        El script del           repo de git 1
        Las variables del       repo de git 2
        ---> Infraestructura... que en terraform se reflejará en terraform.tfstate
        

    Quién ejecuta terraform? Yo ? en mi PC?

    Jenkins
        - Pipeline
            - Ejecuta el script de terraform 
                $ terraform apply --var-file XXXX --auto-aprove --var maquinas_ahora=17 ... donde? 
                    Se ejecutará dentro de un CONTENDOR que tenga instalado TERRAFORM
                        Antes de borrar este contenedor, sacaremos de él el fichero: terraform.tfstate ---> git repo 2
                                                                                                            git repo 2_2
        
    Cuándo querré aplicar una nueva infra para el hospital 1?
        - Tengo un sistema de monitorización... que detecta que las 4 máquinas se han quedado 
          pequeñas.. en cpu ..... MAS MAQUINAS ! Cada día... en intervalos de horas!
        - Cuando el hospital requiera más o menos recursos:
            - Mas copias de los datos... más seguridad... paso del paquete plata -> oro     <<<<  git repo 2
        - Cuando haga un cambio de diseño en la app -> Cambio en la infra                   <<<<  git repo 1

    Mi objetivo como empresa proveedora de este software es GANAR BILLETES €€€€€€€€€
    El hospital me contrata el pack oro: 300 medicos en el hospital: 
        Para atender a 300 medicos estimo que necesito 4 máquinas
        Eso significa que siempre voy a tener arrancadas en AWS las 4 máquinas para ese hospital? NO
        Si hago eso.. por ejemplo, por la noche PIERDO BILLETES que dejo de ingresar en mi cuenta ... y en la de mis empleados
            Y le regalo esos billetes a quién? AWS
        Por la noche me interesará tener 2 máquinas ... el mínimo posible... para urgencias !

    Cada cambio en el fichero variables_hospital_1.tfvars ---> git repo 2 dará lugar a un cambio en el terraform.tfstate? SI
        Evidentement si lo aplico... pero si he cambiado el fichero es para aplicarlo
    Pero... tendré cambios adicionales en el tfstate que surjan por otras cosas más allá de cambios en el fichero de variables? SI
    El tfstate va a ir cambiando mucho... quizás por horas
    El fichero de variables NO.... cambiará muy poco.

    Las 2 cosas (los 2 ficheros) los quiero tener controlados en git

    Me interesa tenerlos en el mismo repositorio? DECISIONES a tomar.
        - Si los tengo en el mismo repo, cuando quiera ver cuándo se ha cambiado la última vez el fichero de variables... me puedo volver loco.
            - Aquí hay algo que puedo usar, que ofrece GIT para ayudarme con esto: RAMAS !
                Me interesaría una rama -> Cambios(COMMITS) en el fichero de variables y otra para los cambios(COMMITS) en el tfstate
        - Otra opción es tener esos ficheros en repositorios distintos.


Quiero controlar 3 cosas diferentes:
- Script
- El(los) fichero(s) de variables para 1 cliente (para una aplciación del script)
- El fichero tfstate
---
$ terraform refresh     Actualiza el tfstate, preguntando al proveedor
    PERO OJO !!!!
    Eso significa que si empiezo de CERO, terraform le pregunta al PROVEEDOR por los 850 mil recursos que tiene allí? NO
    Terraform le pregunta por aquellos recursos que terraform está controlando... que conoce.
$ terraform show        Muestra los recursos y todos sus datos que terraform conoce y está controlando del PROVEEDOR
$ terraform state list  Muestra los nombres de los recursos que terraform conoce y está controlando del PROVEEDOR 
$ terraform state show NOMBRE_DE_UN_RECURSO Muestra los datos de un recurso que terraform conoce y está controlando del PROVEEDOR 
---

BBDD 
- Standalone: Solo 1 nodo, solo 1 máquina
- Cluster Activo/Pasivo: Maestro-Replicas: 3 máquinas -> Alta disponibilidad
    - 1 maquina: Activo: Esta recibe consultas y actualizaciones de datos
    - 2 máquinas que lo que hacen es copias de los datos de la máquina que está activa.
        - Estas máquinas en las BBDD puedo dedicarlas no solo a PASIVOS (a esperar por si el principal / maestro se cae)
          sino también para hacerle consultas -> BusinessIntelligence
- Cluster Activo/Activo: 5 máquinas todas ofreciendo servicio a la vez -> Alta disponibilidad + Escalabilidad

    cluster MariaDB/MySQL (Galera) BBDD 5 nodos:
        MariaDB1    Dato1   Dato2   Dato4
        MariaDB2    Dato1   Dato3   Dato4
        MariaDB3    Dato1   Dato3   Dato5
        MariaDB4    Dato2   Dato3   Dato5
        MariaDB5    Dato2   Dato4   Dato5
        
        Si tengo 1 máquina, cuanto tiempo tardo en guardar 5 datos  = 5 veces el tiempo de guardar 1 dato
        Si tengo 5 máquinas, cuanto tiempo tardo en guardar 5 datos = 3 veces el tiempo de guardar 1 dato

        Con una máquina tardo 5 segundos en guardar 5 datos
        Y con 5 máquinas tardo 3 segundos 
---

Script: Crear en AWS la MAQUINA.hospital1.com

Aplico ese script -> 
    1- Se crea la máquina MAQUINA.hospital1.com
    2- Se apunta en el ficher tfstate que tenemos una maquina llamada MAQUINA.hospital1.com dentro de AWS

Cuántas máquinas tengo en AWS? 850 mil... que incluirán la de el hospital 1... pero trabajo con otros 400 hospitales
    que tendré sus máquinas creadas en AWS.

Cuando el día de mañana cambien una configuración (variables: 30Gbs) en el script... y reejecute. Qué hace terraform ?
Mira el tfstate:
    - Ahora mismo tienes una máquina con 8 CPUs y 16 Gbs de RAM
    - Y tiene un volumen con 20Gbs de espacio
Y lo compara con la nueva configuración... decisión de terraform:               terraform plan
    - Ampliar 10Gbs el disco
Aplicamos el plan:
    - Se emplia el disco
    - Se cambia el tfstate para reflejar la nueva realidad (que tengo un disco de 30Gbs)

Imaginad que pierdo el archivo .tfstate....
Y reejecuto el script. 
Qué hace terraform?
Qué piensa terraform? que no hay nada en el proveedor.
- Intentar de nuevo crear la máquina... Y cuando le pida a AWS: Crea la máquina MAQUINA.hospital1.com
- AWS le va a dar un ostion en to la jeta: ERROR ! La máquina YA EXISTE !