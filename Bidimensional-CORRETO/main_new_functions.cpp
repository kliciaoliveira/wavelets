// Reescrita do programa ondaletas bidimensional em Cplusplus
// função x2 + x + y +1

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

//Funcoes
double funcao (double x, double y)
{
	double res;
	res = 2 + ( (4/3) * y );
	return res;
}


double integral( double inicialx, double finalx, double inicialy, double finaly )
{
    double res = 0;
    const int partes = 16;
//    double soma = 0;
    double x;
    double y;
    
    const double divisao_x = finalx - inicialx ;
    const double divisao_y = finaly - inicialy ;
    
    const double partex = divisao_x/partes ;
    const double partey = divisao_y/partes ;
    
    //    cout << inicialx << "  " << finalx << endl;
    for (x = inicialx; x <= finalx; x+=partex) {
        for (y =inicialy; y <= finaly; y+=partey) {
            double altura = funcao(x,y);
            double cubo = partex*partey*altura;
            //            cout << x << "  " << y << "  "<< " cubo: " <<  cubo << endl;
            res +=cubo;
        }
    }
//    cout << res << endl;
    return(res);
}


//Programa
int main (int argc, char **argv)
{
    cout << "mainhasrun" << endl;
    ofstream myfile;
    ofstream myfile2;
    myfile.open("wave_function.dat");
    myfile2.open("wavediff_function.dat");
    
    // ---- Variaveis globais ----
    //Variaveis de entrada
    const double inicio_x = -1 ;   //Inicio da representacao
    const double inicio_y = -1 ;
    const double fim_x = 8 ;
    const double fim_y = 4;
    const double dom_inf_x = 0 ;   //Inicio do dominio
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 8 ;
    const double dom_sup_y = 4 ;
    const double increment = 0.1 ; //Incremento da representacao
    const double l = 4 ;           // Determinacao de l - passo da varredura
    
    //Variaveis auxiliares de entrada
    int elementos_somaFxy = ceil((abs(inicio_x)+abs(fim_x))/increment);
	int count_cjk=0; //Contador de coeficientes
    
    //Variaveis de saida
    double Fxy = 0;
    double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    
    int min_k1 = dom_inf_x * pow(2,l) ;     // Determinacao dos limites do dominio em relacao a k1 e k2
    int min_k2 = dom_inf_y * pow(2,l) ;
    int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
    int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
    int elementos_cjk = max_k1 + 1;
    double coefcjk [elementos_cjk] [elementos_cjk] ;
    
    int i = 0;
    for(double x = inicio_x ; x <= fim_x ; x += increment){	//--Valores de x e y para tomar da matriz
        for(double y = inicio_y ; y <= fim_y ; y += increment){
            somaFxy [i] = 0;
            for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                    double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
                    double b = pow(2,-l)* ( k1 + 1 ) ;
                    double c = pow(2,-l)* k2 ;
                    double d = pow(2,-l)* ( k2 + 1 ) ;
                    double phi = pow(2,(l*0.5));
                    double cjk = integral( a , b , c , d ) ;     //Calculo da integral
					count_cjk++;
                    int k1_m = floor(x / pow(2,-l)) ;        //VERFIFICAR !! x corresponde a qual par k1 k2 (quadrante)
                    int k2_m = floor(y / pow(2,-l)) ;
                    Fxy = 0;
                    coefcjk [k1_m][k2_m] = cjk * phi * phi ;
                    if ( (x >= a && x <=  b) && (y >= c && y <= d) ){
                        Fxy = coefcjk[k1_m][k2_m] * phi *phi;
                    }
                    somaFxy [i] += Fxy ;
                }
            }
            //cout << "  " << x << "  " << y << "     " << i << "   " << somaFxy [i] << endl;
            double diff = 0;
            if ((x > dom_inf_x && x < dom_sup_x) && (y > dom_inf_y && y < dom_sup_y)) {
                diff = (funcao(x,y) - somaFxy [i] );
            }
            myfile2 << x << "        " << y << "        " <<  diff << endl;
            myfile << x << "        " << y << "        " << somaFxy [i] << endl;
            //cout << "Soma e diferenca:  " <<  x << "  " << y << "  " << diff << "   " << somaFxy [i] << endl;
            i++;

        }
    }
	cout << "O numero de coeficientes cjk para esta representacao eh " << count_cjk << endl;
	cout << "l = " << l << " e o incremento usado eh de  " << increment << endl;
    myfile.close();
    myfile2.close();
    return 0;
}
