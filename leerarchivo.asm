;leerarchivo.asm
%include 'funciones_basicas.asm'
;sys_open   equ 5   ;apertura de archivo
;sys_close  equ 6   ;cierre de archivo

section .data


section .bss

    buffer    resb  1024
    len       equ   1024
    file      resb  20
    filelem   resb  4

section .text

global _start

_start:
    ;vemos los argumentos del sistema operativo
    pop ecx
    pop eax
    dec ecx

    ;abre archivo
    pop ebx
    mov eax, sys_open   ;operacion: abrir archivo
    mov ecx, 0          ;0_RDONLY (solo lectura)
    int 80h
    cmp eax,0
    jle error

    ;lee archivo
    mov ebx, eax        ;pasamos el file handler de EAX a EBX
    mov eax, sys_read   ;operacion: lectura
    mov ecx, buffer     ;direccion de buffer de lectura
    mov edx, lem
    mov 80h
    ;cerrar archivo
    mov eax, sys_exit
    int 80h

    ;imprime buffer
    mov eax, buffer
    call sprintLF

    ;salir
    call quit

error:
      mov ebx, eax
      mov eax, sys_exit
      int 80h
