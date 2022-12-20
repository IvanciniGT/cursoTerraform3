# Expresiones regulares: REGEX

Es una sintaxis heredada de un antiguo lenguaje de programación llamado PERL.

Con esta sintaxis puedo definir el concepto de PATRON

PATRON: Un patrón es un conjunto de SUBPATRONES

SUBPATRON: secuencia de caracteres seguida de un modificador de cantidad

SECUENCIA DE CARACTERES:

    Secuencia de caracteres                 Operación           Texto
    hola                                    contenido en        hola amigo      ? SI 
        Se busca el texto tal cual                              <-->
    hola                                    comienza por ^       hola amigo      ? SI
    hola                                    acaba por    $       hola amigo      ? NO
    [hola]                                  contenido en        hola amigo      ? SI
        Cualquiera de esos caracteres                           ^^
    [a-z]
    [A-Z]
    [a-z0-9ñ.]
    .   
        Cualquier caracter


MODIFICADORES DE CANTIDAD

                                        SE SUPONE QUE DEBE APARECER 
    si no pongo nada                    1 vez exacta
    {3}                                 3 veces
    {3,8}                               De 3 a 8 veces
    ?                                   Puede aparecer o no
    +                                   Al menos 1 vez
    *                                   Puede no aparecer o hacerlo montonon de veces

Pagina guay para trabajar con regex: regex101.com
^[a-zA-Z][a-zA-Z0-9.-_]{5,20}$

