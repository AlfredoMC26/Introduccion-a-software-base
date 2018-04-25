;funciones.asm
;Alfredo Murillo

%include './funciones_basicas.asm'     ;llamar a funciones_basicas

SECTION .text                          ;indica el inicio del programa
global _start

_start:
    pop   ecx                          ;el primer valor en el stack es el de arg

sigArg:
    cmp   ecx, 0h                      ;comparamos con 0
    jz    nomasArgs                    ;si es 0 vamos a nomasArgs
    pop   eax                          ;tomamos el sigArg
    call  sprintLF                     ;imprimimos el arg
    dec   ecx                          ;ecx son los argumentos
    jmp   sigArg                       ;recusivo

nomasArgs:
    call  salida

salida:                                ;salimos del programa
    mov   eax,sys_exit
    int   0x80
