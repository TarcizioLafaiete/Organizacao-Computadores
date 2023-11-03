.data
vetor: .word 1 2 3 4 5 6 7
.text
main:
la x12, vetor
addi x13, x0, 7
addi x13, x13, -1
slli x13, x13, 2
add x13, x13, x12
jal x1, inverte
beq x0, x0, FIM
##### START MODIFIQUE AQUI START #####
inverte: bgt x12, x13,retorno # Condicao para o retorno da recursao
         addi x2,x2,-4 #Aloca posicao na stack
         sw x1,0(x2) #salva retorno na pilha
         lw x5,0(x12) 
         lw x6,0(x13)
         sw x6,0(x12)
         sw x5,0(x13)
         addi x12,x12,4
         addi x13,x13,-4
         jal x1,inverte
retorno: lw x1,0(x2)
         addi x2,x2,4
         jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10