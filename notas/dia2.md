# Terraform 

- Un lenguaje declarativo llamado HCL, que usamos para montar scripts
- Un comando llamado terraform que nos permite aplicar verbos sobre el script
    - init          Descargar providers
    - validate
    - refresh       Refresca el estado actual (el fichero terraform.tfstate), preguntando al proveedor
    - plan          Compara el *estado actual* de nuestro sistema/entorno con el definido en el código y...
                    calcula un plan de ejecución para conseguir que:
                    > *Estado actual* de nuestro sistema/entorno = definido en el código
    - destroy

# Provider

En un programa que necesitamos descargar en nuestra computadora y que terraform 
usa para comunicarse con un externo que nos proporciona recursos

# Estado actual de nuestro sistema

Si terraform cree que en mi computadora tengo ya o no esos recursos.
Y esa información es la que se encuentra en el fichero terraform.tfstate

--- 

Script :                                    Estado actual:                              Estado real:

Quiero tener un entorno/sistema con:        Lo que terraform cree/sabe que tengo        Tengo un entorno con:
- un contenedor (nginx)                     terraform.tfstate
- una imagen de contenedor (nginx)                                                      - una imagen de contenedor (nginx)


# Script de terraform:

Un directorio en el que tenemos al menos un fichero .tf

En los ficheros .tf definimos bloques de código:
- terraform         Definir los proveedores
- provider          Configurar los proveedores
- resource          Definir un recurso
    - provisioners  A dia de hoy en terraform existen solo 3 tipos de provisionadores
- output            Extraer información de un recurso
- variable          Parametrizar el script
- locals            Definir "variables internas"
- data
- module

---

Tipos de datos en Terraform

- number
- string
- bool
- list(x)       Lista de valores. Podemos acceder a ellos por su posición
- set(x)        Lista de valores. Solo podemos iterarlos
- map(x)        Conjunto de claves-valores
                    {
                        nombre  = "Ivan"
                        edad    = 44
                    }
- object(x)     Un objeto es como un map, pero...
                    - Las claves están predefinidas, no se pueden usar otras
                    - Asociado a cada clave puedo poner un tipo de dato distinto

Adicionalmente, al configurar recursos aparecen propiedades de tipo block (block list | block set)
A la hora de asignarlos, no se usa el signo =, sino solamente llaves

----


Jenkins 
1 - Llamar a un script de terraform para crear unos servidores en amazon
        VVVV - IP servidor
2 - Llamar a un playbook de ansible para planchar esos servidores
3 - ...


---

Nevera                              Entorno
* Felipón:  Mayordomo                 Jenkins
* Pepito:   El que hace la compra     Terraform
    vvv                                  vvv        
* Lucas:    El que hace la comida     Ansible

Si, lo puedo hacer... Y NO LO HARIA EN MI PUÑETERA VIDA !!!!


Mi objetivo es tener programas / trabajadores TOTALMENTE DESACOPLADOS
Que no dependan unos de otros.

Si el día de mañana cambio a Lucas (Ansible) por Margarita(Puppet) 
necesito hacer algún cambio en Pepito (Terraform) NO QUIERO 

25000 maquinas !
        comidas cada comida va con su receta ! playbook

Jenkins -> Terraform Y le pide: Crea un servidor
            Y terraform, contesta: Y devuelve la IP
Jenkins -> Ansible Y le pide: Configura esa máquina
            Y le da el qué? La IP en el formato adecuado
            Y ansible hace su trabajo y contestará.. con lo que sea 

Podría Jenkins leer la IP del nuevo servidor/contenedor... lo que sea del fichero terraform.tfstate? SI
De nuevo, NO LO HARIA EN MI PUÑETERA VIDA ! Por qué?

---

    ----------------------------- red de amazon -----------------------------
    |                                                           |
    172.31.20.235:8080->172.17.0.2:80                     172.31.20.201
    |                                                           |
    IvanPC-127.0.0.1-loopback                               MenchuPC
      |
      172.17.0.1
      |
      docker
      |
      172.17.0.2:80 apache
      |
      contenedor apache :80
      
---
# Formas de asignar valor a una variable en TERRAFORM

- Al invocar el script con el comando terraform.
    - Si una variable no tiene valor, terraform lo solicita interactivamente.
      NOTA: Si no ponemos un valor en este punto, terraform corta la ejecución del comando.
        TERRAFORM NUNCA PERMITIRA LA EJECUCION DE UN SCRIPT DONDE HAYA VARIABLES SIN ASIGNAR
      NOTA2: Nunca jamás usamos esto .. me cargo la automatización
    - Podemos suministrar una variable con el argumento --var seguido de "variable=valor"
      NOTA: Usamos esto mucho?
            No lo usamos mucho... Por qué? 
            Dónde queda reflejado que he ejecutado el script con este valor?
            No queda registro de esto... No queda ni huella.. como la lejia estrella!
      NOTA2: Arriba he preguntado si lo usabamos "mucho".... Si hay un escenario de uso. Cuál?
            Cuando no quiera dejar ni huella de una variable ! -> CREDENCIAL !
    - Podemos asignar valores de variables en ficheros con extension .tfvars, que se suministren
      al comando terraform mediante el argumento --var-file NOMBRE-DEL-FICHERO
      NOTA: ESTA LA REQUETEBUENA !!!!!!
            Estos ficheros van a mi repo del SCM.. donde tendré control de todos 
            los cambios realizados en las variables
Podemos definir variables en un fichero ( o varios) con la extensión .auto.tfvars.
Esos ficheros no es necesario suministrarlos como argumentos en los scripts.
Eso se toma como valores por defecto.

# Prioridad de los valores de las variables

1º El que se pase como --var
2º El que se pase como --var-file
3º El que vaya en un fichero .auto.tfvars
4º El que se hubiera definido como DEFAULT dentro de la variable
5º Si no paso valor en ninguna de esas formas, se solicita interactivamente


---
Está nuestro script a prueba de manazas? Me temo que no. 