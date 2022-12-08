; Autor reseni: Oleksandr Turytsia xturyt00

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xturyt00"  ; sem doplnte vas login
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text

                ; ZDE NAHRADTE KOD VASIM RESENIM
                ;r20-r12-r7-r17-r0-r4
main:
                while_start:

                sub r20, r20, r20
                sub r17, r17, r17
                sub r4, r4, r4

                lb r1, login(r7)     

                slti r12, r1, 97    

                bnez r12, while_end  

                addi r17, r17, 2

                ddiv r7, r17

                mfhi r17

                bnez r17, goto_second

                goto_first:

                addi r20, r20, 122

                addi r1, r1, 20      

                ddiv r1, r20        

                mfhi r17           

                slti r12, r1, 123

                bnez r12, skip_shift_right 
                
                addi r1, r1, -26

                skip_shift_right:

                b next_iteration

                goto_second:

                addi r20, r20, 96

                addi r1, r1, -21     

                ddiv r20, r1         

                mfhi r17             

                slti r12, r1, 97

                beqz r12, skip_shift_left

                addi r4, r4, 122

                sub r1, r4, r17

                skip_shift_left:

                nop

                next_iteration:

                sb r1, cipher(r7)

                addi r7, r7, 1

                b while_start

                while_end:

                daddi r4, r0, cipher

                jal print_string

                halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
