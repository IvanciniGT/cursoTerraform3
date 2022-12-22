# Modulo para gestionar claves publicas / privadas que poder usar en comunicaciones ssh

## Funcionalidad

El módulo debe ser capaz de generar una pareja de claves publica/privada

El módulo debe darnos un output con las claves publica y privada en forma pem y openssh

El módulo además, al generar un par de claves, debe guardar esas claves (en formato pem y openssh) en 4 ficheros
dentro de un directorio personalizable, con los nombres:
- privatekey.openssh
- privatekey.pem
- publickey.openssh
- publickey.pem

El módulo debe permitir varios algoritmos de generación de claves: 
- RSA
- ECDSA
- ED25519

Cada algoritmo puede tener sus propios parámetros de configuración:
- RSA:          Número de bytes
- ECDSA         P224, P256, P384, P521
- ED25519       Nada

El módulo, al arrancar, debe revisar si ya existen ficheros de claves (los 4) en el directorio suministrado.
- Si no existen, debe generar las claves, y los ficheros.
- Si existen, revisará el valor de una variable de configuración que llamaremos `force-generate`.
    - Si la variable está en true, también debe generar la pnueva pareja de claves, sobreescribiendo los ficheros que existan.
    - Si la variable está en false, debe leer los ficheros y usar su contenido para el output, no generando claves nuevas.

## Ejemplo de uso

```tf

module "misclaves" {
    algorithm       = {
                        name    = "RSA"
                        config  = 2048
                      }
    #algorithm       = {
    #                    name    = "ECDSA"
    #                    config  = "P224"
    #                  }
    #algorithm       = {
    #                    name    = "ED25519"
    #                  }
    keys_path       = './claves' # Directorio donde se deben guardar las claves / de donde se deben leer las claves
    force_generate  = false      # true
}   

...{
    module.misclaves. # < De aqui sacar mediante un output tanto la clave publica como la privada en formato pem o openssh
}

```

## Para hacer esto, usaremos un proveedor que ya existe en terraform: `hashicorp/tls`

variables : 60 lineas
outputs:    20 lineas 
main:       42 lineas