// Reescrita do programa ondaletas bidimensional em Cplusplus
// função x2 + x + y +1

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

//Funcoes
double integral( double inicialx, double finalx, double inicialy, double finaly )
{
    double res = 0;
    const int partes = 16;
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

    return(res);
}

double calculos_djk (double j, int k1, int k2)
{
    // cout << j << "  "  << k1 << "  "  << k2 << endl;
    double res2;
    // a, b, c e d são os limites das integrais
    double i1 = pow(2,-j)* k1 ;      		//--Gerando a matriz
    double f1 = pow(2,-j)* ( k1 + 1 ) ;
    double i2 = pow(2,-j)* k2 ;
    double f2 = pow(2,-j)* ( k2 + 1 ) ;
    double m1 = pow(2,-j)* ( k1 + 0.5 ) ;
    double m2 = pow(2,-j)* ( k2 + 0.5 ) ;
    
    double psi_unsigned = pow(2,(j*0.5));
    double phii = psi_unsigned;
    
    // para a integral horizontal integral * phi j,k1 * psi j,k2
    double djk_int1 = integral( i1 , f1 , i2 , m2 ) ;     //Calculo da integral x no dominio phi e y no dominio psi
    double djk_int2 = integral( i1 , f1 , m2 , f2 ) ;     //dominio x eh o mesmo, soh mudo y porque psi muda de sinal
    double horizontal = phii * (djk_int1 * psi_unsigned + (djk_int2 * (-psi_unsigned)));
    
    // para a integral diagonal integral * psi j, k1 * psi j,k2
    djk_int1 = integral( f1 , m1 , f2 , m2 ) ;
    djk_int2 = integral( m1 , f1 , m2 , f2 ) ;
    double djk_int3 = integral( m1 , f1 , i2 , m2 ) ;
    double djk_int4 = integral( i1 , m1 , m2 , f2 ) ;
    
    double diagonal=djk_int1+djk_int2+djk_int3+djk_int4 ;
    
    double vertical=0;

    //cout << horizontal << "  "  << vertical << "  "  << diagonal << endl;
    
    res2 = horizontal+vertical+diagonal;
    
    return(res2);
}


//Programa
int main (int argc, char **argv)
{
    ofstream myfile;
    ofstream myfile2;
    myfile.open("wave.dat");
    myfile2.open("wavediff.dat");
    
    // ---- Variaveis globais ----
    //Variaveis de entrada
    const double inicio_x = -1 ;   //Inicio da representacao
    const double inicio_y = -1 ;
    const double fim_x = 3 ;
    const double fim_y = 3;
    const double dom_inf_x = 0 ;   //Inicio do dominio
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 2 ;
    const double dom_sup_y = 2 ;
    const double increment = 0.1 ; //Incremento da representacao
    const double l = 1 ;           // Determinacao de l - passo da varredura
    const double j_max = 9;
    
    
    //Variaveis auxiliares de entrada
    int elementos_somaFxy = ceil((abs(inicio_x)+abs(fim_x))/increment);
    
    //Variaveis de saida
    double Fxy = 0;
    double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    double somaDjk [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    
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
            somaDjk [i] = 0;
            for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                    double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
                    double b = pow(2,-l)* ( k1 + 1 ) ;
                    double c = pow(2,-l)* k2 ;
                    double d = pow(2,-l)* ( k2 + 1 ) ;
                    double phi = pow(2,(l*0.5));
                    double cjk = integral( a , b , c , d ) ;     //Calculo da integral
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
            // *** introdução do somatorio djk (comentar secao para usar somente o primeiro somatorio)
            for (double j=l; j<=j_max; j++) {
                for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                    for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                        double djk_soma = calculos_djk(j, k1, k2);
                        somaDjk [i] += djk_soma;
                        cout << djk_soma << "  " << i << endl;
                    }
                }
            }
            // ***
            //cout << "  " << x << "  " << y << "     " << i << "   " << somaFxy [i] << endl;
            double diff = 0;
            if ((x > dom_inf_x && x < dom_sup_x) && (y > dom_inf_y && y < dom_sup_y)) {
                diff = ((x*x + x + y + 1) - somaFxy [i] );
            }
            myfile2 << x << "        " << y << "        " <<  diff << endl;
            myfile << x << "        " << y << "        " << somaFxy [i] + somaDjk[i] << endl;
            cout << somaDjk [i] << endl;
            i++;
        }
    }
    myfile.close();
    myfile2.close();
    return 0;
}
