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
- object(x)

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