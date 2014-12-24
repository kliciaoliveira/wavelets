// Reescrita do programa ondaletas bidimensional em Cplusplus

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

//Funcoes
double integral( double inicialx, double finalx, double inicialy, double finaly )
{
    double res;

    double parcial1 = ((finalx-inicialx)/2)*(finaly*finaly) + (((finalx*finalx*finalx)/3) - ((inicialx*inicialx*inicialx)/3) + ((finalx*finalx)/2) - ((inicialx*inicialx)/2) + finalx - inicialx)*finaly;
    double parcial2 = ((finalx -inicialx)/2)*(inicialy*inicialy)  + (((finalx*finalx*finalx)/3) - ((inicialx*inicialx*inicialx)/3) + ((finalx*finalx)/2) - ((inicialx*inicialx)/2) + finalx - inicialx)*inicialy;

    res = parcial1 - parcial2;

    return(res);
}
double calculoPhi( double t , double l, double k )
{
    cout << "rodou calculoPhi" << endl ;
    
    return(0);
}
double calculoMae()
{
    cout << "Calculo_mae chamada" << endl;
    return(0);
}

//Programa
int main (int argc, char **argv)
{
    cout << "mainhasrun" << endl;
    ofstream myfile;
    myfile.open("wave.dat");

    // ---- Variaveis globais ----
    //Variaveis de entrada
    double x;
    double y;
    const double inicio_x = -1 ;
    const double dom_inf_x = 0 ;
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 2 ;
    const double dom_sup_y = 2 ;
    const double inicio_y = -1 ;
    const double detail = 0.1 ;
    const double fim_x = 2 ;
    const double fim_y = 2;
    
 
    //Variaveis de saida
    double Fxy = 0;
    

    const double l = 1 ;                    // Determinacao de l - passo da varredura
    int min_k1 = dom_inf_x * pow(2,l) ;     // Determinacao dos limites do dominio em relacao a k1 e k2
    int min_k2 = dom_inf_y * pow(2,l) ;
    int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
    int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
    int elementos = max_k1 + 1;
    int elementos_somaFxy = ceil(dom_sup_x/detail);
    double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    double coefcjk [elementos] [elementos] ;
    int n, m;
    int i = 1;
    for(double x = 0.1 ; x <= 2 ; x += detail){	//--Valores de x e y para tomar da matriz
	for(double y = 0.1 ; y <= 2 ; y += detail){
	  somaFxy [i] = 0;
	  for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
	    for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
	    double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
	    double b = pow(2,-l)* ( k1 + 1 ) ;
	    double c = pow(2,-l)* k2 ;
	    double d = pow(2,-l)* ( k2 + 1 ) ;
	    double phi = pow(2,(l*0.5));
	    double cjk = integral( a , b , c , d ) ;     //Calculo da integral
	    coefcjk [k1][k2] = cjk * phi * phi ;		//Matriz gerada
	    int k1_m = floor(x / pow(2,-l)) ;        //x corresponde a qual par k1 k2
	    int k2_m = floor(y / pow(2,-l)) ;
	    Fxy = 0;
	    coefcjk [k1_m][k2_m] = cjk * phi * phi ;
	    if ( (x >= a && x <=  b) && (y >= c && y <= d) ){
	      Fxy = coefcjk[k1_m][k2_m] * phi *phi;		
	    } else {
	      Fxy= 0.;
	    }
	    somaFxy [i] += Fxy ;
// 	    cout << i << "  " << x << "  " << y << "  " << Fxy << "  " << somaFxy [i] << endl;
 	    
// 	    cout << i << "  " << somaFxy [i] << endl;
	    
	    
	    }
	    
	  }
	  cout << "  " << x << "  " << y << "  " << somaFxy [i] << endl;
	  myfile << x << "   " << y << "  " << Fxy << endl;
// 	  cout << i << "  " << somaFxy[i] << "  " << Fxy << endl; 

	  i++;
	  
	}
	}
    
          /*for(int j = min_Somatorio; j < max_Somatorio; j++) {
                for(int k1 = -1; k1 <= 1; k1++) {
                    for(int k2 = -1; k2 <= 1; k2++) {
                        for (int sinal = 1; sinal < 3; sinal++) {
                            somaMae += calculoMae();
                        }
                    }
                }
            }*/
    

    myfile.close();
    return 0;
}
