.data
vetor: .word 4 5 5 4 3 9 1 5 0 0 0 1 8 1
##### START MODIFIQUE AQUI START #####
verificador: .word 6 5 4 3 2 9 8 7 6 5 4 3 2
##### END MODIFIQUE AQUI END #####
.text
main:
la x12, vetor #passando o ponteiro do vetor como parametro
addi x13, x0, 14  #passando o tamanho do vetor como parametro
addi x14, x0, 1 #passando se deve ser verificado CNPJ ou CPF
jal x1, verificadastro #chama funcao de verificacao de cadastro
beq x0,x0,FIM
##### START MODIFIQUE AQUI START #####
#Funcao verifica CPF
verificacpf: 
addi x2,x2,-4 #Aloca espaço na pilha 
sw x1,0(x2) #Salva valor de retorno de verifica CPF
add x5,x0,x12 #recebe vetor
addi x6,x0,10 #valor multiplicativo usado no processo de verificao
add x7,x0,x0 #resultado ou produto
add x28,x0,x0 #iterador
addi x29,x0,9 #limite da iteracao
add x30,x0,x0 #montante
add x31,x0,x0 #valor i do vetor
add x10,x0,x0 #retorno da funcao
beq x0,x0,L1
CM1:
lw x31,0(x5) #Puxa da memoria o valor apontado no vetor
addi x5,x5,4 #Vai para o proximo valor
mul x7,x31,x6 #Multiplica o valor de vetor[i] com o atual valor de x6
add x30,x30,x7 #Adiciona o resultado da multiplicacao ao montante
addi x6,x6,-1 #Decresce 1 de x6 para a proxima iteracao
addi x28,x28,1 #aumenta o valor do iterador para se aproximar da condicao de parada
L1:
blt x28,x29,CM1 #Condição de parada de um loop for
rem x7,x30,x13 #Salva em x7 o resultado do resto entre o montante e o tamanho do vetor
sub x7,x13,x7 #Subtrai o resto guardado em x7 por 11 e guarda em x7 novamente
blt x7,x29,FOLLOW1 #x29 nesse momento tem valor 9, entao caso x7 seja menor que 9 vai para FOLLOW1
beq x7,x29,FOLLOW1 #Caso x7 igual a 9 tem vai para FOLLOW1
add x7,x0,x0 #Caso x7 > 9 entao x7 = 0
FOLLOW1:
add x5,x0,x12 #Retorna o ponteiro para posicao inical do vetor
lw x31,36(x5) #Salva em x31 o valor correspondente a vetor[9]
beq x7,x31,OK1 #Caso o valor de x7 calculado anterior igual a x31 entao o digito verificador esta correto
beq x0,x0,retornocpf #Retorna CPF como errado
OK1:
add x30,x0,x0 #reseta x30
add x7,x0,x0 #reseta x7
addi x6,x0,11 #Coloca 11 como valor multiplicativo inicial
add x28,x0,x0 #Zera o iterador
addi x29,x0,10 #Valor de parada do loop for
beq x0,x0,L2 #incio do Loop
CM2:
lw x31,0(x5) #Puxa da memoria valor do vetor
addi x5,x5,4 #Pula pra proxima posicao do vetor
mul x7,x31,x6 #multiplica x6 pelo valor de vetor[i]
add x30,x30,x7 #adiciona o produto da multiplicacao em x30
addi x6,x6,-1 #Subtrai um de x6 para a proxima iteração
addi x28,x28,1 #Adiciona 1 para ir a proxima iteracao
L2:
blt x28,x29,CM2 #Condicao de parada
rem x7,x30,x13 #Calula o resto de x30 por 11
sub x7,x13,x7 #Subtrai de 11 o resto calculado
addi x29,x0,9 #Salva 9 em x29 para comparacao
blt x7,x29,FOLLOW2 #Caso x7 menor que 9 segue para FOLLOW2 
beq x7,x29,FOLLOW2 #Caso x7 igual a 9 segue para FOLLOW2
add x7,x0,x0 #Caso seja maior que 9 zera x7
FOLLOW2:
add x5,x0,x12 #Retorna o ponteiro em x5 para a primeira posicao do vetor
lw x31,40(x5) #Aloca em x31 o valor de vetor[10]
beq x7,x31,OK2 #Caso o resultado salvo em x7 for igual a vetor[10] segue para OK2
beq x0,x0,retornocpf #caso x7 != vetor[10] retorna cpf como invalido
OK2:
addi x10,x0,1 #Resposta = 1, cpf valido
retornocpf:
lw x1,0(x2) #Envia para x1 o valor do retorno salvo na stack
addi x2,x2,4 #Desloca posicao da stack
jalr x0, 0(x1) #retorno de funcao
#Funcao verifica CNPJ
verificacnpj: 
addi x2,x2,-4 #Cria nova posicao na stack
sw x1,0(x2) #Aloca o valor de retorno
add x5,x12,x0 #recebe ponteiro para o vetor
la x6,verificador #recebe vetor de verificacao do CNPJ
add x7,x0,x0 #iterador
addi x28,x0,12 #limite
add x29,x0,x0 #montante e resultado
add x30,x0,x0 #vetor[i] do CNPJ
add x31,x0,x0 #vetor[i] do verificador e produto
add x10,x0,x0 #retorno da verificacao
beq x0,x0,L3 #Inicia loop for
CM3:
lw x30,0(x5) #x30 recebe vetor[i]
addi x5,x5,4 #Pula para proxima posicao do vetor
lw x31,4(x6) #x31 recebe verificador[i + 1]
addi x6,x6,4 #Pula para a proxima posicao do vetor
mul x31,x30,x31 #x31 recebe o produto de vetor[i] e verificador[i+1]
add x29,x29,x31 #x29 guarda o somatorio do x31 das n iteracoes
addi x7,x7,1 #Incrementa iterador
L3:
blt x7,x28,CM3 #Loop repete ate x7 ser menor que 12
addi x7,x0,11 #x7 recebe 11
rem x29,x29,x7 #x29 recebe o resto do somatorio em x29 por 11
addi x7,x0,2 #x7 recebe 2
blt x29,x7,ZERO1 #caso o resultado salvo em x29 for menor que 2 vai a ZERO1
addi x7,x0,11 #X7 recebe 11
sub x29,x7,x29 #x29 se torna a subtração de 11 pelo resto salvo em x29
beq x0,x0,TEST1 #Pula para TEST1
ZERO1:
add x29,x0,x0 #resultado em x29 é igual a 0
TEST1:
add x5,x0,x12 #Reseta x5 para a primeira posicao do vetor
lw x30,48(x5) #x30 recebe vetor[12]
beq x29,x30,OK3 #Caso o resultado em x29 for igual a vetor[30] vai a OK3
beq x0,x0,retornocnpj #Caso não retorna cnpj invalido
OK3:
add x5,x0,x12 #Reseta x5 para a primeira posicao do vetor(redundante)
la x6,verificador #Reseta x6 para a primeira posicao do verificador
add x7,x0,x0 #Iterador em 0
addi x28,x0,13 #valor do fim da iteracao
#Resete de registradores temporarios
add x29,x0,x0 
add x30,x0,x0
add x31,x0,x0
beq x0,x0,L4 #Pula para L$
CM4:
lw x30,0(x5) #x30 recebe vetor[i]
addi x5,x5,4 #pula para proxima posicao do vetor
lw x31,0(x6) #x31 recebe verificador[i]
addi x6,x6,4 #pula para a proxima posicao de verificador
mul x31,x30,x31 #x31 guarda o produto de verificador[i] por vetor[i]
add x29,x29,x31 #x29 guarda o somatorio de x31 nas n iteracoes
addi x7,x7,1 #incrementa iterador
L4:
blt x7,x13,CM4 #CM4 se repetira até x7 ser igual a 13
addi x7,x0,11 #x7 recebe 11
rem x29,x29,x7 #x29 recebe o resto de x29 por 11
addi x7,x0,2 #x7 recebe 2
blt x29,x7,ZERO2 #caso x29 for menor que 2 então vai ate ZERO2
addi x7,x0,11 #x7 recebe 11
sub x29,x7,x29 #x29 recebe a subtracao de 11 por x29(resultado do resto)
beq x0,x0,TEST2 #pula ate TEST2
ZERO2:
add x29,x0,x0 #x29 recebe 0
TEST2:
add x5,x0,x12 #reseta a posicao do vetor
lw x30,52(x5) #x30 recebe vetor[13]
beq x29,x30,OK4 #caso x30 igual a x29 pula para OK4
beq x0,x0 retornocnpj #retorna cnpj invalido
OK4:
addi x10,x0,1 #saida = 1 indica que o codigo verficador e valido
retornocnpj:
lw x1,0(x2) #x1 recebe o valor de retorno salvo na stack
addi x2,x2,4 #Desaloca posicao na stack
jalr x0, 0(x1) #retorno da funcao
#funcao verifica cadastro
verificadastro: 
addi x2,x2,-4  #Pula para a proxima posicao da pilha para guadar um novo valor
sw x1,0(x2) #Salva na pilha o valor de retorno dentro de verifica cadastro dentro da pilha
beq x14, x0,tamanhoCPF  #Se x14 conter 0 se trata de uma verificacao de CPF, caso nao e uma verificacao de CNPJ
addi x7,x0,14 #Guarda 14 em um variavel temporaria
bne x7,x13,falhaCNPJ #verifica se o tamanho de vetor passado com CNPJ e condiziente
jal x1,verificacnpj #Chama a funcao para verificar o CNPJ passado
falhaCNPJ:
beq x0,x0,retornocadastro #Retorna cadastro
tamanhoCPF:
addi x7,x0,11 #Guarda 11 em uma variavel temporaria
beq x13,x7,chamaCPF #Caso o tamanho do vetor seja condizente vai verificar o CPF
beq x0,x0,retornocadastro #Retorna cadastro
chamaCPF: 
jal x1,verificacpf #chama o procedimento verificacpf
beq x0,x0,retornocadastro #retorna cadastro
retornocadastro:
lw x1,0(x2) #recupera a variavel de returno da pilha
addi x2,x2,4 #Desaloca a pilha
jalr x0, 0(x1) #retorno de procedimento
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10