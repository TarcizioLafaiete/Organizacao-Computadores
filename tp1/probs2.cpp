#include <iostream>

int verificador[13] = {6,5,4,3,2,9,8,7,6,5,4,3,2};

int verificaCPF(int *vetor,int tamanho){
    int montante = 0; //x5
    int produto = 0;  //x6
    int aux = 10; //x7
    int i = 0; //x28
    int limite = 9; //x29
    int resultado = 0; //x30
    int saida;
    for(;i<limite;i++){
        produto = vetor[i] * aux; //vetor[i] = x31
        montante = montante + produto;
        aux --;
    }
    resultado = montante%11;
    resultado = 11 - resultado;
    if(resultado > 9){
        resultado = 0;
    }
    if(resultado != vetor[9]){
        saida = 0;
        return saida;
    }
    montante = 0;
    produto = 0;
    aux = 11;
    i = 0;
    limite = 10;
    resultado = 0;
    for(;i<limite;i++){
        produto = vetor[i]*aux;
        montante = montante + produto;
        aux --;
    }
    resultado = montante%11;
    resultado = 11 - resultado;
    if(resultado > 9){
        resultado = 0;
    }
    if(resultado != vetor[10]){
        saida = 0;
        return saida;
    }
    saida = 1;
    return saida;
}
int verificaCNPJ(int *vetor,int tamanho){

    int i = 0;
    int limite = 12;
    int montante = 0;
    int produto = 0;
    int resultado = 0;
    int saida  = 0;
    for(;i<limite;i++){
        produto = vetor[i] + vetor[i+1];
        montante = montante + produto;
    }
    resultado = montante%11;
    if(resultado < 2){
        resultado = 0;
    }
    else{
        resultado = 11 - resultado;
    }
    if(resultado != vetor[12]){
        return saida;
    }
    i = 0;
    produto = 0;
    montante = 0;
    limite = 13;
    resultado = 0;
    for(;i < limite;i++){
        produto = vetor[i] + vetor[i];
        montante = montante + produto;
    }
    resultado = montante%11;
    if(resultado < 2){
        resultado = 0;
    }
    else{
        resultado = 11 - resultado;
    }
    if(resultado != vetor[13]){
        return saida;
    }
    saida = 1;
    return saida;
}
void verificaCadastro(int *vetor,int tamanho,int tipo){
    if(tipo == 0){
        std::cout<<verificaCPF(vetor,tamanho)<<std::endl;
    }
    else{
        verificaCNPJ(vetor,tamanho);
    }
}
int main(){

    int vetor[14] = {0,2,0,7,5,7,4,3,6,7,3};
    int tamanho = 11;
    int tipo = 0;
    verificaCadastro(vetor,tamanho,tipo);
    return 0;
}