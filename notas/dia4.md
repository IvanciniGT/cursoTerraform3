# Repaso miercoles:

- Variables
- Bucle
    - En linea, para inyectar valores en propiedades de recursos, para hacer validaciones, para rellenar outputs: `[ for .... in ....: ... ]`
    - Para crear bloques (propiedades que eran un poco especiales) dentro de recursos:
        - dynamic, content, for_each (que recibía? una lista), iterator
    - Para generar recursos masivamente:
        - count    (count.index)                                                                -> La variable del recurso: 
                                                                                                    Apunta a una lista de recursos                           
        - for_each (each: each.key, each.value; que recibía? un mapa o una lista de strings)    -> La variable del recurso:
                                                                                                    Apunta a un mapa de recursos   
# Provisioners

Acciones que podíamos ejecutar al crear/modificar (por defecto) un recurso o al eliminarlo (when = destroy)

Tenemos 3 tipos de provisionadores y solo 3:
- Local-exec    Ejecutar un comando en el entorno donde estamos corriendo terraform
    - Propiedades que podemos configurarle:
        - command
        - when = destroy
        - interpreter
        - environment
        - on_failure = continue
    - Usos:
        - Realizar pruebas de humo
        - Extraer datos en el momento de la creación / eliminación
- Remote-exec   Ejecutar un comando o script en el entorno que estamos configurando
                Conocer datos de conectividad de ese entorno
                Credenciales: ssh / winrm

- File          Copiar/crear un fichero en el entorno que estamos configurando

Al definir un provisionador en un recurso que está siendo creado de forma masiva, en bucle (count, for_each), el provisionador se ejecuta
para cada instancia del recurso. Este comportamiento por defecto de terraform no es siempre satisfactorio para nosotros.
En esos casos, donde la sintaxis de terraform se nos queda chica, podemos hacer uso del proveedor NULL ~> null_resource