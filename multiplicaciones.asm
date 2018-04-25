;multiplicaciones.asm
;Alfredo Murillo

%include './funciones_basicas.asm'     ;llamamos a funciones_basicas

SECTION .text:                         ;indica el inicio del programa
GLOBAL _start

_start:
    pop   ecx                          ;el primer valor del stack es el argumento

multiplicar:
    cmb   ecx, 0h                      ;comparamos el valor con 0
    jz    nomasArgs                    ;si es 0 vamos a nomasArgs
    pop   eax                          ;tomamos el segundo valor
    

nomasArgs:
    call  salida                       ;vamos a salida

salida:                                ;salimos del programa
    mov   eax,sys_exit                 ;sys_exit
    int   0x80                         ;llamamos al kernel
