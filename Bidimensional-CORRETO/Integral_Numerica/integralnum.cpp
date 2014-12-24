// Reescrita do programa ondaletas bidimensional em Cplusplus
// função x2 + x + y +1

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

//Programa
int main (int argc, char **argv)
{
    double res = 0;
    const int partes = 8;
    double soma = 0;
    double x;
    double y;
    
    const double inicialx = 0 ;   //Inicio do dominio
    const double inicialy = 0 ;
    const double finalx = 2 ;
    const double finaly = 2 ;
    

    
    const double divisao_x = finalx - inicialx ;
    const double divisao_y = finaly - inicialy ;
    
    const double partex = divisao_x/partes ;
    const double partey = divisao_y/partes ;
    
    cout << partex << "   " << partey << endl;
    
    //    cout << inicialx << "  " << finalx << endl;
    for (x = inicialx; x <= finalx; x+=partex) {
        for (y =inicialy; y <= finaly; y+=partey) {
            double altura = pow(x,2) + x + y + 1;
            double cubo = partex*partey*altura;
//            cout << x << "  " << y << "  "<< " cubo: " <<  cubo << endl;
            res +=cubo;
        }
    }
    cout << res << endl;
    return 0;
}
