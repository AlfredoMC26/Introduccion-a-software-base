;escribearchivo.asm
;Alfredo Murillo
;lunes 23 Abril 2018


%include 'funciones_basicas.asm'

segment .funciones_basicas
        buffer_alumno RESB 30
        len_alumno EQU $-buffer_alumno

        filename RESB 30
        len_filename EQU $-len_filename

        archivo RESB 30

section .data
        p_nombre DB "Nombre del alumno" ,0x0
        p_archivo DB "Nombre del archivo" ,0x0

section .text
        global _start

_start:

        mov eax, p_nombre                                            ;preguntar por nombre de alumno
        call sprint                              ;imprime el mensaje

        mov ecx, buffer_alumno                   ;captura el buffer_alumno
        mov edx, len_alumno                      ;con longitud maxima de len_alumno
        call LeerTexto                           ;input desde el teclado

        mov esi, archivo                        ;copia hasta archivo
        mov eax, filename                       ;desde filename
        call copystring                         ;pero sin el caracter 0xA

;create file
        mov eax, sys_creat                       ;sys_creat EQU 8
        mov ebx, archivo                         ;nombre de archivo
        mov ecx, 332                             ;511 = rwxr-xr-x
                                                 ;5 = rwxr
                                                 ;1 = r-x
                                                 ;7 = -wx
                                                 ;6 = rwx
                                                 ;4 = r-T
                                                 ;3 = -wx
                                                 ;2 = rwx
        int 0x80                                 ;ejecuta (llama al sistema op.)

        cmp eax, 0
        jle error                                ;si es 0 o menos, error al abrir

;open file for write
        mov eax, sys_open                        ;abrir archivo
        mov ebx, archivo                         ;nombre de archivo desde archivo
        mov ecx, O_RDWR                          ;abrir el modo de lectura
        int 0x80                                 ;ejecutar
        cmp eax,0
        jle error


;write
        mov ebx, eax                             ;file handle a ebx

        mov eax, sys_write
        mov ecx, buffer_alumno
        mov edx, len_alumno
        int 0x80
        mov eax, sys_sync                        ;sincroniza discos (forzar escritura)
        int 0x80                                 ;sys_sync

;close file
        mov eax,sys_close
        int 0x80


salida:
        jmp quit

error:
        mov ebx,eax
        mov eax,sys_exit
        int 0x80
