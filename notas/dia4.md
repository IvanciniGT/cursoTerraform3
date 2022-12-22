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

---

Cuando escribimos un programa, tiramos el código ahí en un fichero tal cual linea destrás de linea? NO
El código que vamos escribiendo normalmente (es decir SIEMPRE !!!!!) lo agrupamos en paquetes, unidades de código:

función | métodos | procedimientos

Qué nos permite el organizar el código en funciones? Qué ganamos?
- Posibilidad de REUTILIZARLO
- Tener un programa MAS ORGANIZADO ~> MAS FACILMENTE MANTENIBLE
    - SonarQube ~> Análisis de calidad de código

Pruebas funcionales: Unitarias, integración...
SENIOR !!!


Una función | método tiene:
- nombre
** argumentos | parametros <- datos de entrada que me permiten personalizar el comportamiento que quiero para la función
** Unos valores que devuelve

Esas funciones también existen en TERRAFORM, y se llaman: MODULOS

Un módulo es:
Un conjunto de recursos que vamos a crear (reutilizables),
junto con unas variables que permiten su parametrización                    ** Argumentos, parametros
junto con unos datos que se devuelven de los recursos                       ** Los valores que devuelve

Un modulo de terraform es:
- Una marca terraform
- Un conjunto de resources
- Un conjunto de variables
- Un conjunto de outputs
- Aquí NO DOY configuracióndel provider... está pensado para ser REUTILIZABLE !
    - Será quién use el modulo el que dará la configruación del provider!

En un script de terraform de los que hemos creado hasta ahora, que teníamos:
- Un conjunto de resources
- Un conjunto de variables
- Un conjunto de outputs
- Una marca terraform
- Una marca provider donde damos ? La configuración del provider

---
Maquina linux

Que voy a necesitar para conectarme a ella? CREDENCIALES: usuario [+password] / clave publica + clave privada

Maquina local ---ssh---> Servidor remoto
Usuario Ivan             Clave publica
Clave privada


Clave publica + clave privada:
- Autenticación
- Encripción > Frustrar un tipo de ataque muy común que nos pueden realizar (y que es INEVITABLE): Man-in-midle

Lo que encriptamos con la clave privada solo se puede desencriptar con la publica (NI SIQUIERA CON LA PRIVADA)
---
Vamos a generar un módulo en terraform para gestionar claves publicas / privadas