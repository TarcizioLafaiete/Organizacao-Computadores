#include <iostream>

int vetor[7] = {1,2,3,4,5,6,7};

void inverte(int x, int y){
    int aux;
    if( x > y){
        return;
    }
    aux = vetor[x];
    vetor[x] = vetor[y];
    vetor[y] = aux;
    x ++;
    y --;
    inverte(x,y);

}

int main(){

    int x = 0;
    int y = sizeof(vetor)/sizeof(int);
    inverte(x,y - 1);
    for(int i = 0;i < 7;i++){
        std::cout<<vetor[i]<<std::endl;
    }
    return 0;
}